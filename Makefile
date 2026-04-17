NAME = libasm.a
TEST_NAME = test_libasm
NASM = nasm
NASMFLAGS = -f elf64 -g
AR = ar rcs
CC = gcc
CFLAGS = -Wall -Wextra -Werror -g
RM = rm -f

SRCS = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s
OBJS = $(SRCS:.s=.o)

all: $(NAME)

$(NAME): $(OBJS)
	$(AR) $(NAME) $(OBJS)

%.o: %.s
	$(NASM) $(NASMFLAGS) $< -o $@

main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o

$(TEST_NAME): $(NAME) main.o
	$(CC) $(CFLAGS) main.o -L. -lasm -o $(TEST_NAME)

clean:
	$(RM) $(OBJS) main.o

fclean: clean
	$(RM) $(NAME) $(TEST_NAME)

re: fclean all

test-%: all
	@echo "Building stress test suite..."
	@gcc -Wall -Wextra -Werror tests/$*.test.c -L. -lasm -o $*_test
	@./$*_test
	@rm -f $*_test

valtest-%: all
	@echo "Building valgrind test for $*..."
	@gcc -Wall -Wextra -Werror tests/$*.test.c -L. -lasm -o $*_test
	@valgrind --leak-check=full ./$*_test
	@rm -f $*_test

.PHONY: all clean fclean re test