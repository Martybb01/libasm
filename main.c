#include "libasm.h"

static void	print_result(int pass)
{
	printf("  Result: %s\n\n", pass ? "✓ PASS" : "✗ FAIL");
}

// ============================================================
// FT_STRLEN
// ============================================================

void	test_strlen(void)
{
	printf("\n=== TESTING FT_STRLEN ===\n");

	const char *cases[] = {
		"",
		"a",
		"42",
		"I am Spiderman",
		"abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ",
		NULL
	};

	for (int i = 0; cases[i] != NULL; i++)
	{
		size_t expected = strlen(cases[i]);
		size_t result   = ft_strlen(cases[i]);

		printf("strlen(\"%s\"):\n", cases[i]);
		printf("  strlen=%zu  ft_strlen=%zu\n", expected, result);
		print_result(result == expected);
	}
}

// ============================================================
// FT_STRCPY
// ============================================================

void	test_strcpy(void)
{
	printf("\n=== TESTING FT_STRCPY ===\n");

	const char *cases[] = { "", "a", "42", "I am SpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpiderman", NULL };

	for (int i = 0; cases[i] != NULL; i++)
	{
		char	real_dst[4096] = {0};
		char	ft_dst[4096]   = {0};

		char	*real_ret = strcpy(real_dst, cases[i]);
		char	*ft_ret   = ft_strcpy(ft_dst, cases[i]);

		int		content_ok  = strcmp(real_dst, ft_dst) == 0;
		int		real_ptr_ok = real_ret == real_dst;
		int		ft_ptr_ok   = ft_ret   == ft_dst;

		printf("strcpy(\"%s\"):\n", cases[i]);
		printf("  content:    expected=\"%s\"  ft=\"%s\"  %s\n",
			real_dst, ft_dst, content_ok ? "✓" : "✗");
		printf("  return ptr: real_ok=%d  ft_ok=%d\n", real_ptr_ok, ft_ptr_ok);
		print_result(content_ok && real_ptr_ok && ft_ptr_ok);
	}
}

// ============================================================
// FT_STRCMP
// ============================================================

void	test_strcmp(void)
{
	printf("\n=== TESTING FT_STRCMP ===\n");

	struct { const char *s1; const char *s2; } cases[] = {
		{ "Spiderman", "Spiderman" },  // equal
		{ "Spiderman", "Spidey"   },  // differ mid-string
		{ "Spidey",    "Gwen"     },  // differ at first char
		{ "",          ""         },  // both empty
		{ "",          "Spiderman"},  // s1 shorter
		{ "Spiderman", ""         },  // s2 shorter
		{ "abc",       "abd"      },  // differ at last char (s1 < s2)
		{ "abd",       "abc"      },  // differ at last char (s1 > s2)
		{ "ab",        "abc"      },  // s1 is prefix of s2
		{ "abc",       "ab"       },  // s2 is prefix of s1
		{ NULL, NULL }
	};

	for (int i = 0; cases[i].s1 != NULL; i++)
	{
		int	real = strcmp(cases[i].s1, cases[i].s2);
		int	ft   = ft_strcmp(cases[i].s1, cases[i].s2);

		// POSIX richiede solo il segno, non il valore esatto
		int	real_sign = (real > 0) - (real < 0);
		int	ft_sign   = (ft   > 0) - (ft   < 0);

		printf("strcmp(\"%s\", \"%s\"):\n", cases[i].s1, cases[i].s2);
		printf("  real=%d (sign=%+d)  ft=%d (sign=%+d)\n",
			real, real_sign, ft, ft_sign);
		print_result(real_sign == ft_sign);
	}
}

// ============================================================
// FT_WRITE
// ============================================================

void	test_write(void)
{
	printf("\n=== TESTING FT_WRITE ===\n");

	// Test 1: Scrivo su una pipe e rileggo per verificare il contenuto
	{
		int			pfd[2];
		const char	*msg = "Hello from ft_write!";
		char		buf[256] = {0};

		pipe(pfd);
		ssize_t ft_ret = ft_write(pfd[1], msg, strlen(msg));
		close(pfd[1]);
		ssize_t n = read(pfd[0], buf, sizeof(buf) - 1);
		close(pfd[0]);
		(void)n;

		printf("Write to pipe \"%s\":\n", msg);
		printf("  ft_write returned: %zd  expected: %zu\n", ft_ret, strlen(msg));
		printf("  content read back: \"%s\"\n", buf);
		print_result(ft_ret == (ssize_t)strlen(msg) && strcmp(buf, msg) == 0);
	}

	// Test 2: Return value uguale a write() reale
	{
		int			pfd1[2], pfd2[2];
		const char	*msg = "SpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpidermanSpiderman\n";

		pipe(pfd1);
		pipe(pfd2);
		ssize_t ft_ret   = ft_write(pfd1[1], msg, strlen(msg));
		ssize_t real_ret = write(pfd2[1], msg, strlen(msg));
		close(pfd1[0]); close(pfd1[1]);
		close(pfd2[0]); close(pfd2[1]);

		printf("Return value for \"%s\":\n  write=%zd  ft_write=%zd\n",
			msg, real_ret, ft_ret);
		print_result(ft_ret == real_ret);
	}

	// Test 3: Caso di errore (fd=-1) — controlla ret=-1 e errno corretto
	{
		ssize_t	ft_ret, real_ret;
		int		ft_errno, real_errno;

		errno = 0;
		ft_ret   = ft_write(-1, "test", 4);
		ft_errno = errno;

		errno = 0;
		real_ret   = write(-1, "test", 4);
		real_errno = errno;

		printf("Error case (fd=-1):\n");
		printf("  write:    ret=%zd, errno=%d (%s)\n",
			real_ret, real_errno, strerror(real_errno));
		printf("  ft_write: ret=%zd, errno=%d (%s)\n",
			ft_ret, ft_errno, strerror(ft_errno));
		print_result(ft_ret == real_ret && ft_errno == real_errno);
	}

	// Test 4: Scrivo 0 bytes
	{
		int		pfd[2];
		char	buf[4] = {0};

		pipe(pfd);
		ssize_t ft_ret   = ft_write(pfd[1], buf, 0);
		ssize_t real_ret = write(pfd[1], buf, 0);
		close(pfd[0]); close(pfd[1]);

		printf("Write 0 bytes:\n  write=%zd  ft_write=%zd\n", real_ret, ft_ret);
		print_result(ft_ret == real_ret);
	}
}

// ============================================================
// FT_READ
// ============================================================

void	test_read(void)
{
	printf("\n=== TESTING FT_READ ===\n");

	// Test 1: Leggo un file e confronto con read() reale
	{
		const char	*filename = "test_read.txt";
		char		ft_buf[4096]   = {0};
		char		real_buf[4096] = {0};

		int fd = open(filename, O_RDONLY);
		if (fd < 0)
		{
			perror("open");
			printf("  Skipping file test (could not open \"%s\")\n\n", filename);
		}
		else
		{
			ssize_t ft_bytes = ft_read(fd, ft_buf, sizeof(ft_buf) - 1);
			close(fd);

			fd = open(filename, O_RDONLY);
			ssize_t real_bytes = read(fd, real_buf, sizeof(real_buf) - 1);
			close(fd);

			if (ft_bytes >= 0)   ft_buf[ft_bytes]     = '\0';
			if (real_bytes >= 0) real_buf[real_bytes]  = '\0';

			printf("File \"%s\":\n", filename);
			printf("  read=%zd bytes  ft_read=%zd bytes\n", real_bytes, ft_bytes);
			int ok = ft_bytes == real_bytes
				&& (ft_bytes < 0 || strcmp(ft_buf, real_buf) == 0);
			print_result(ok);
		}
	}

	// Test 2: Leggo da pipe
	{
		int			pfd[2];
		const char	*msg = "Spiderman reads assembly!";
		char		buf[256] = {0};

		pipe(pfd);
		write(pfd[1], msg, strlen(msg));
		close(pfd[1]);

		ssize_t ft_ret = ft_read(pfd[0], buf, sizeof(buf) - 1);
		close(pfd[0]);

		printf("Read from pipe:\n");
		printf("  expected: \"%s\" (%zu bytes)\n", msg, strlen(msg));
		printf("  ft_read:  \"%s\" (%zd bytes)\n", buf, ft_ret);
		print_result(ft_ret == (ssize_t)strlen(msg) && strcmp(buf, msg) == 0);
	}

	// Test 3: Caso di errore (fd=-1) — controlla ret=-1 e errno corretto
	{
		char		buf[16];
		ssize_t		ft_ret, real_ret;
		int			ft_errno, real_errno;

		errno = 0;
		ft_ret   = ft_read(-1, buf, sizeof(buf));
		ft_errno = errno;

		errno = 0;
		real_ret   = read(-1, buf, sizeof(buf));
		real_errno = errno;

		printf("Error case (fd=-1):\n");
		printf("  read:    ret=%zd, errno=%d (%s)\n",
			real_ret, real_errno, strerror(real_errno));
		printf("  ft_read: ret=%zd, errno=%d (%s)\n",
			ft_ret, ft_errno, strerror(ft_errno));
		print_result(ft_ret == real_ret && ft_errno == real_errno);
	}

	// Test 4: Leggo 0 bytes
	{
		int		pfd[2];
		char	buf[4] = {0};

		pipe(pfd);
		write(pfd[1], "data", 4);
		ssize_t ft_ret   = ft_read(pfd[0], buf, 0);
		ssize_t real_ret = read(pfd[0], buf, 0);
		close(pfd[0]); close(pfd[1]);

		printf("Read 0 bytes:\n  read=%zd  ft_read=%zd\n", real_ret, ft_ret);
		print_result(ft_ret == real_ret);
	}
}

// ============================================================
// FT_STRDUP
// ============================================================

void	test_strdup(void)
{
	printf("\n=== TESTING FT_STRDUP ===\n");

	const char *cases[] = { "Hello Spiderman", "", "42", NULL };

	for (int i = 0; cases[i] != NULL; i++)
	{
		char	*real_dup = strdup(cases[i]);
		char	*ft_dup   = ft_strdup(cases[i]);

		int content_ok  = ft_dup && strcmp(real_dup, ft_dup) == 0;
		int diff_ptr    = ft_dup != NULL && (void *)ft_dup != (void *)cases[i];

		// Indipendenza: modificare la copia non deve toccare l'originale
		int independent = 1;
		if (ft_dup && cases[i][0] != '\0')
		{
			char saved  = ft_dup[0];
			ft_dup[0]   = 'X';
			independent = (cases[i][0] != 'X');
			ft_dup[0]   = saved;
		}

		printf("strdup(\"%s\"):\n", cases[i]);
		printf("  content match: %s\n", content_ok  ? "✓" : "✗");
		printf("  different ptr: %s\n", diff_ptr    ? "✓" : "✗");
		printf("  independent:   %s\n", independent ? "✓" : "✗");
		print_result(content_ok && diff_ptr && independent);

		free(real_dup);
		free(ft_dup);
	}
}

// ============================================================
// MAIN
// ============================================================

int	main(void)
{
	printf("=== LIBASM FUNCTION TESTS ===\n");
	printf("Testing your assembly functions against standard library functions\n");

	test_strlen();
	test_strcpy();
	test_strcmp();
	test_write();
	test_read();
	test_strdup();

	printf("\n=== ALL TESTS COMPLETED ===\n");
	return (0);
}
