
void kernel_entry() {
    char *vmem = (char *) 0xb8000;
    char *str = "Hallo Welt!";
    
    char *read = str;
    unsigned char count = 0;
    
    while (*str != '\0') {
        *(vmem+count) = *str;
        ++str;
        count += 2;
    }
    
    while(1){};
}
