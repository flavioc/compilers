
#include <stdio.h>

#define ROWS 2
#define COLS 3

#define AT(X, I, M, J) (*(X + I * M + J))
#define TILLING_ROWS 2
#define TILLING_COLS 3

inline min(int a, int b) { return a > b ? b : a; }

void
transpose(int *x, int *y, const int rows, const int cols)
{
   int i, j, it, jt;

   for(it = 0; it < rows; it += TILLING_ROWS) {
      for(jt = 0; jt < cols; jt += TILLING_COLS) {
         for(i = it; i < min(rows, it + TILLING_ROWS); i++) {
            for(j = jt; j < min(cols, jt + TILLING_COLS); j++) {
               AT(y, j, cols, i) = AT(x, i, rows, j);
            }
         }
      }
   }
}

void
print(int *x, const int rows, const int cols)
{
   int i, j;

   for(i = 0; i < rows; i++) {
      for(j = 0; j < cols; j++)
         printf("%d ", AT(x, i, rows, j));
      printf("\n");
   }
}

int
main(int argc, char **argv)
{
   int m[ROWS][COLS] = {{1, 2, 3}, {4, 5, 6}};
   int n[COLS][ROWS];

   print(*m, ROWS, COLS);
   transpose(*m, *n, ROWS, COLS);
   print(*m, ROWS, COLS);
   print(*n, COLS, ROWS);

   return 0;
}
