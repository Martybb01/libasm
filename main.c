#include "libasm.h"

// size_t ft_strlen(const char *s);
// char *ft_strcpy(char *dst, const char *src);
// int ft_strcmp(const char *s1, const char *s2);
// ssize_t ft_write(int fd, const void *buf, size_t count);
// ssize_t ft_read(int fd, void *buf, size_t count);
// char *ft_strdup(const char *s);

void test_strlen() {
    printf("\n=== TESTING FT_STRLEN ===\n");
    
    char *test_strings[] = {
        "",
        "42",
        "I am Spiderman",
        "a",
        NULL
    };
    
    for (int i = 0; test_strings[i] != NULL; i++) {
        size_t real_len = strlen(test_strings[i]);
        size_t ft_len = ft_strlen(test_strings[i]);
        
        printf("String: \"%s\"\n", test_strings[i]);
        printf("  strlen:    %zu\n", real_len);
        printf("  ft_strlen: %zu\n", ft_len);
        printf("  Result: %s\n\n", (real_len == ft_len) ? "✓ PASS" : "✗ FAIL");
    }
}

void test_strcpy() {
    printf("\n=== TESTING FT_STRCPY ===\n");
    
    char *test_strings[] = {
        "",
        "42",
        "I am Spiderman",
        "a",
        NULL
    };
    
    for (int i = 0; test_strings[i] != NULL; i++) {
        char real_dst[100];
        char ft_dst[100];
        
        char *real_result = strcpy(real_dst, test_strings[i]);
        char *ft_result = ft_strcpy(ft_dst, test_strings[i]);
        
        printf("Source: \"%s\"\n", test_strings[i]);
        printf("  strcpy result:    \"%s\" (ptr: %p)\n", real_dst, real_result);
        printf("  ft_strcpy result: \"%s\" (ptr: %p)\n", ft_dst, ft_result);
        
        int strings_match = strcmp(real_dst, ft_dst) == 0;
        int pointers_match = (real_result == real_dst) && (ft_result == ft_dst);
        
        printf("  Result: %s\n\n", (strings_match && pointers_match) ? "✓ PASS" : "✗ FAIL");
    }
}

void test_strcmp() {
    printf("\n=== TESTING FT_STRCMP ===\n");
    
    struct {
        char *s1;
        char *s2;
    } test_pairs[] = {
        {"Spiderman", "Spiderman"},
        {"Spiderman", "Spidey"},
        {"Spidey", "Gwen"},
        {"", ""},
        {"", "Spiderman"},
        {"Spiderman", ""},
        {NULL, NULL}
    };
    
    for (int i = 0; test_pairs[i].s1 != NULL; i++) {
        int real_result = strcmp(test_pairs[i].s1, test_pairs[i].s2);
        int ft_result = ft_strcmp(test_pairs[i].s1, test_pairs[i].s2);
        
        // Normalize results to -1, 0, 1
        int real_norm = (real_result > 0) ? 1 : (real_result < 0) ? -1 : 0;
        int ft_norm = (ft_result > 0) ? 1 : (ft_result < 0) ? -1 : 0;
        
        printf("Comparing: \"%s\" vs \"%s\"\n", test_pairs[i].s1, test_pairs[i].s2);
        printf("  strcmp:    %d (normalized: %d)\n", real_result, real_norm);
        printf("  ft_strcmp: %d (normalized: %d)\n", ft_result, ft_norm);
        printf("  Result: %s\n\n", (real_norm == ft_norm) ? "✓ PASS" : "✗ FAIL");
    }
}

void test_write() {
    printf("\n=== TESTING FT_WRITE ===\n");
    
    char *test_strings[] = {
        "Hello from Your Friendly Neighborhood Spider-Man!\n",
        "42\n",
        NULL
    };
    
    for (int i = 0; test_strings[i] != NULL; i++) {
        printf("Writing: \"%s\"", test_strings[i]);
        ssize_t result = ft_write(1, test_strings[i], strlen(test_strings[i]));
        printf("ft_write returned: %zd\n\n", result);
    }
}

void test_read() {
    printf("\n=== TESTING FT_READ ===\n");
    printf("This test requires manual input. Type something and press Enter:\n");
    
    char buffer[100];
    ssize_t bytes_read = ft_read(0, buffer, sizeof(buffer) - 1);
    
    if (bytes_read > 0) {
        buffer[bytes_read] = '\0';
        printf("ft_read returned %zd bytes: \"%s\"\n", bytes_read, buffer);
    } else {
        printf("ft_read returned: %zd\n", bytes_read);
    }
}

void test_strdup() {
    printf("\n=== TESTING FT_STRDUP ===\n");
    
    char *test_strings[] = {
        "Hello Spiderman",
        "",
        "42",
        NULL
    };
    
    for (int i = 0; test_strings[i] != NULL; i++) {
        char *real_dup = strdup(test_strings[i]);
        char *ft_dup = ft_strdup(test_strings[i]);
        
        printf("Original: \"%s\"\n", test_strings[i]);
        printf("  strdup:    \"%s\" (ptr: %p)\n", real_dup, real_dup);
        printf("  ft_strdup: \"%s\" (ptr: %p)\n", ft_dup, ft_dup);
        
        int strings_match = strcmp(real_dup, ft_dup) == 0;
        int different_ptrs = (real_dup != ft_dup);
        
        printf("  Result: %s\n\n", (strings_match && different_ptrs) ? "✓ PASS" : "✗ FAIL");
        
        free(real_dup);
        free(ft_dup);
    }
}

int main() {
    printf("=== LIBASM FUNCTION TESTS ===\n");
    printf("Testing your assembly functions against standard library functions\n");
    
    test_strlen();
    test_strcpy();
    test_strcmp();
    test_write();
    test_strdup();
    test_read();
    
    printf("\n=== ALL TESTS COMPLETED ===\n");
    return 0;
}