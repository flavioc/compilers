
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

void transpose2(int  *x, int  *y) {
   int i, it, j, jt, scaledit, scaledjt, temp1_0, temp2_0
      , temp3_0;
   for(it = 0; it <= 1; it++) {
      scaledit = it;
      for(jt = 0; jt <= 2; jt++) {
         scaledjt = jt;
         temp1_0 = (0 + scaledit);
         temp2_0 = temp1_0;
         temp1_0 = (temp1_0 + 0);
         temp2_0 = (temp2_0*3);
         temp2_0 = (temp2_0 + 0);
         temp2_0 = (temp2_0 + scaledjt);
         temp2_0 = (temp2_0 + 0);
         temp3_0 = (0 + scaledjt);
         temp3_0 = (temp3_0*2);
         temp1_0 = (temp1_0 + temp3_0);
         y[temp1_0] = x[temp2_0];
      }
   }
}

int
main(int argc, char **argv)
{
   int m[ROWS][COLS] = {{1, 2, 3}, {4, 5, 6}};
   int n[COLS][ROWS];

   print(*m, ROWS, COLS);
   //transpose(*m, *n, ROWS, COLS);
   transpose2(*m, *n);
   print(*n, COLS, ROWS);

   return 0;
}
