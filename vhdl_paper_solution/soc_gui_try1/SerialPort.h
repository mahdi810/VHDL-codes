#include <iostream>
#include <string>
#include <windows.h>

class SerialPort {
private:
    HANDLE hSerial;
    std::string portName;

public:
    SerialPort(const std::string& port, DWORD baudRate = CBR_115200) {
        portName = "\\\\.\\" + port;  // handles COM10 and above
        hSerial = INVALID_HANDLE_VALUE;
        open(baudRate);
    }

    ~SerialPort() {
        close();
    }

    bool open(DWORD baudRate) {
        // open the port
        hSerial = CreateFileA(
            portName.c_str(),
            GENERIC_READ | GENERIC_WRITE,
            0,              // no sharing
            NULL,           // no security
            OPEN_EXISTING,
            0,              // non-overlapped
            NULL
        );

        if (hSerial == INVALID_HANDLE_VALUE) {
            std::cerr << "failed to open port: " << portName << std::endl;
            return false;
        }

        // configure timeouts
        COMMTIMEOUTS timeouts = {0};
        timeouts.ReadIntervalTimeout         = 50;
        timeouts.ReadTotalTimeoutConstant    = 50;
        timeouts.ReadTotalTimeoutMultiplier  = 10;
        timeouts.WriteTotalTimeoutConstant   = 50;
        timeouts.WriteTotalTimeoutMultiplier = 10;
        SetCommTimeouts(hSerial, &timeouts);

        // configure port parameters
        DCB dcbSerialParams = {0};
        dcbSerialParams.DCBlength = sizeof(dcbSerialParams);

        if (!GetCommState(hSerial, &dcbSerialParams)) {
            std::cerr << "failed to get port state" << std::endl;
            close();
            return false;
        }

        dcbSerialParams.BaudRate = baudRate;
        dcbSerialParams.ByteSize = 8;           // 8 data bits
        dcbSerialParams.StopBits = ONESTOPBIT;  // 1 stop bit
        dcbSerialParams.Parity   = NOPARITY;    // no parity

        if (!SetCommState(hSerial, &dcbSerialParams)) {
            std::cerr << "failed to set port state" << std::endl;
            close();
            return false;
        }

        std::cout << "connected to " << portName 
                  << " at " << baudRate << " baud" << std::endl;
        return true;
    }

    void close() {
        if (hSerial != INVALID_HANDLE_VALUE) {
            CloseHandle(hSerial);
            hSerial = INVALID_HANDLE_VALUE;
        }
    }

    bool isOpen() const {
        return hSerial != INVALID_HANDLE_VALUE;
    }

    // send a string
    bool write(const std::string& data) {
        if (!isOpen()) return false;

        DWORD bytesWritten = 0;
        if (!WriteFile(hSerial, data.c_str(), data.size(), &bytesWritten, NULL)) {
            std::cerr << "write failed" << std::endl;
            return false;
        }
        return bytesWritten == data.size();
    }

    // read up to maxBytes, returns what was received
    std::string read(DWORD maxBytes = 256) {
        if (!isOpen()) return "";

        std::string result(maxBytes, '\0');
        DWORD bytesRead = 0;
        ReadFile(hSerial, &result[0], maxBytes, &bytesRead, NULL);
        result.resize(bytesRead);
        return result;
    }

    // read until newline or timeout
    std::string readLine() {
        std::string line;
        char c;
        DWORD bytesRead;

        while (true) {
            ReadFile(hSerial, &c, 1, &bytesRead, NULL);
            if (bytesRead == 0) break;   // timeout
            if (c == '\n') break;
            if (c != '\r') line += c;
        }
        return line;
    }
};