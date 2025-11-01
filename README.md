# libasm

# 🧠 libasm

**libasm** is a small educational project that reimplements a few standard C library functions — entirely in **x86-64 assembly** using **NASM** and the **Intel syntax**.  
It’s designed to help understand how low-level operations, system calls, and calling conventions work behind the scenes.

## 🧩 Overview

This library reproduces several well-known libc functions:

- `ft_strlen` — returns the length of a string  
- `ft_strcpy` — copies a string to another buffer  
- `ft_strcmp` — compares two strings  
- `ft_write` — performs a system write  
- `ft_read` — performs a system read  
- `ft_strdup` — duplicates a string (using `malloc`)

Each function is implemented in pure assembly, compiled into a static library called **`libasm.a`**.

## ⚙️ Build & Run

```bash
make
```

## 🧪 Testing
A `main.c` file is provided to test each function and compare results with the standard C library equivalents.
