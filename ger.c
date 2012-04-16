
#include "util.h"

#define TILLING_ROWS 2
#define TILLING_COLS 1

void
dger(int *a, int *x, int *y, const int alpha, const int m, const int n)
{
   int i, j, it, jt;

   for(it = 0; it < m; it += TILLING_ROWS) {
      for(jt = 0; jt < n; jt += TILLING_COLS) {
         for(i = it; i < min(m, it + TILLING_ROWS); ++i) {
            for(j = jt; j < min(n, jt + TILLING_COLS); ++j) {
               AT(a, i, n, j) = AT(a, i, n, j) + alpha * x[i] * y[j];
            }
         }
      }
   }

}

void ger2(int  *a, int  *x, int  *y, int alpha) {
   int i, it, j, jt, scaledit, scaledjt;
   for(it = 0; it <= 2; it++) {
      scaledit = it;
      for(jt = 0; jt <= 1; jt++) {
         scaledjt = jt;
         a[(((0 + scaledit)*2) + ((0 + scaledjt) + 0))] = (a[(((0 + scaledit)*2) + ((0 + scaledjt) + 0))] + (alpha*(x[(0 + scaledit)]*y[(0 + scaledjt)])));
      }
   }
}

void ger3(int  *a, int  *x, int  *y, int alpha) {
   int i, it, j, jt, scaledit, scaledjt;
   for(it = 0; it <= 2; it++) {
      scaledit = it;
      scaledjt = (0*2);
      a[(((0 + scaledit)*2) + (0 + scaledjt))] = (a[(((0 + scaledit)*2) + (0 + scaledjt))] + (alpha*(x[(0 + scaledit)]*y[(0 + scaledjt)])));
      a[(((0 + scaledit)*2) + ((0 + scaledjt) + 1))] = (a[(((0 + scaledit)*2) + ((0 + scaledjt) + 1))] + (alpha*(x[(0 + scaledit)]*y[(0 + scaledjt)])));
   }
}

int
main(int argc, char **argv)
{
#define ROWS 3
#define COLS 2

   int m[ROWS][COLS] = {{1, 2},
                        {3, 4},
                        {5, 6}};
   int x[ROWS] = {5, 10, 15};
   int y[COLS] = {2, 3};
   int alpha = 2;

   print(*m, ROWS, COLS);
   ger3(*m, x, y, alpha);
   print(*m, ROWS, COLS);

   return 0;
}
