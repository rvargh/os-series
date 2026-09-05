#include "print.hpp"

extern "C" void kernel_main() {
    print_clear();
    print_set_color(PRINT_COLOR_YELLOW, PRINT_COLOR_BLACK);
    print_str("Hello from C++!\n");
    print_str("Kernel is running...\n");
}