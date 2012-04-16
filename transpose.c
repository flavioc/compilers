
#include "util.h"

#define ROWS 2
#define COLS 3

#define TILLING_ROWS 2
#define TILLING_COLS 3

void
transpose(int *x, int *y, const int rows, const int cols)
{
   int i, j, it, jt;

   for(it = 0; it < rows; it += TILLING_ROWS) {
      for(jt = 0; jt < cols; jt += TILLING_COLS) {
         for(i = it; i < min(rows, it + TILLING_ROWS); i++) {
            for(j = jt; j < min(cols, jt + TILLING_COLS); j++) {
               AT(y, j, rows, i) = AT(x, i, cols, j);
            }
         }
      }
   }
}

int
main(int argc, char **argv)
{
   int m[ROWS][COLS] = {{1, 2, 3}, {4, 5, 6}};
   int n[COLS][ROWS];

   print(*m, ROWS, COLS);
   transpose(*m, *n, ROWS, COLS);
   print(*n, COLS, ROWS);

   return 0;
}
