
#include <stdio.h>
#include "util.h"

void
print(int *x, const int rows, const int cols)
{
   int i, j;

   for(i = 0; i < rows; i++) {
      for(j = 0; j < cols; j++) {
         printf("%d ", AT(x, i, cols, j));
      }
      printf("\n");
   }
}
