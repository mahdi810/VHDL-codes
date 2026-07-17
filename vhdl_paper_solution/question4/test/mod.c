#include <stdio.h>

int main()
{
    printf("mod calculatior\n");
    long long int a, b;
    printf("Enter two numbers: ");
    scanf("%lld %lld", &a, &b);
    printf("The remainder is: %lld\n", a % b);
    return 0;
}