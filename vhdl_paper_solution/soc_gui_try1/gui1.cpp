#include <iostream>
#include <winddi.h>
#include "SerialPort.h"




int main() {
    // change COM3 and baud rate to match your setup
    // for PYNQ-Z2 PS UART: typically 115200
    SerialPort serial("COM3", CBR_115200);

    if (!serial.isOpen()) {
        std::cerr << "could not open port, exiting" << std::endl;
        return 1;
    }

    std::string input;
    std::cout << "type commands to send (q to quit):" << std::endl;

    while (true) {
        std::cout << ">> ";
        std::getline(std::cin, input);

        if (input == "q") break;

        // send command with carriage return (matches your VHDL getline)
        serial.write(input + "\r\n");

        // read response
        std::string response = serial.readLine();
        if (!response.empty()) {
            std::cout << "received: " << response << std::endl;
        }
    }

    return 0;
}
