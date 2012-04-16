
#define AT(X, I, M, J) (*(X + I * M + J))

void print(int *, const int rows, const int cols);
inline int min(int a, int b) { return a > b ? b : a; }
