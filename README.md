# MatrixCalculator

## Compile
make.sh will generate the excecutable file.
```
$ ./make.sh
```

## Test Case
#### Sample Input
```
[2,1]^T*[2,1]
```
#### Sample Output
```
Accepted
```

#### Sample Input
```
([2,3]*[2, 3]^T)^T+[4,1]
```
#### Sample Output
```
Semantic error on col 19
```

#### Sample Input
```
([1,2]+[2,1]^T)*[1,3]*[1,3]^T*[3,3]
```
#### Sample Output
```
Semantic error on col 16
```

#### Sample Input
```
([1,2]+[2,1]^T)*[1,3]*[1,3]^T*[3,3]
```
#### Sample Output
```
Accepted
```
