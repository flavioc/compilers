
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

void ger4(int  *a, int  *x, int  *y, int alpha) {
   int i, it, j, jt, scaledit, scaledjt, temp1_0, temp1_1
      , temp2_0, temp2_1, temp3_0, temp3_1, temp4_0, temp4_1;
   for(it = 0; it <= 2; it++) {
      scaledit = it;
      scaledjt = (0*2);
      temp1_0 = (0 + scaledit);
      temp2_0 = temp1_0;
      temp3_0 = (0 + scaledjt);
      temp4_0 = (x[temp2_0]*y[temp3_0]);
      temp4_0 = (alpha*temp4_0);
      temp1_0 = (temp1_0*2);
      temp1_0 = (temp1_0 + 0);
      temp1_0 = (temp1_0 + scaledjt);
      temp1_0 = temp1_0;
      a[temp1_0] = (a[temp1_0] + temp4_0);
      temp1_1 = (0 + scaledit);
      temp2_1 = temp1_1;
      temp3_1 = (0 + scaledjt);
      temp4_1 = (x[temp2_1]*y[temp3_1]);
      temp4_1 = (alpha*temp4_1);
      temp1_1 = (temp1_1*2);
      temp1_1 = (temp1_1 + 0);
      temp1_1 = (temp1_1 + scaledjt);
      temp1_1 = (temp1_1 + 1);
      a[temp1_1] = (a[temp1_1] + temp4_1);
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
   ger4(*m, x, y, alpha);
   print(*m, ROWS, COLS);

   /* should output this:
      1 2 
      3 4 
      5 6 
      21 22 
      43 44 
      65 66 
      */

   return 0;
}
