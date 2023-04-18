## ÖZEL BUYRUKLARI DESTEKLEYEN LLVM/CLANG TABANLI DERLEYİCİ

Aşağıdaki şekilde kurabilirsiniz:

```bash
git clone https://github.com/llvm/llvm-project
cd llvm-project
git checkout 1fdec59bffc11ae37eb51a1b9869f0696bfd5312
git apply derleyici.patch
```

Daha sonra bağlılıkları yükleyip kütüphaneyi build edin:

```bash
sudo apt update
sudo snap refresh
sudo apt install gcc g++
sudo snap install cmake --classic
sudo apt install ninja-build

cd llvm-project
mkdir build
cd build
export CXXFLAGS="-std=c++11 -include limits"
cmake -G Ninja \
-DCMAKE_BUILD_TYPE=Release \
-DLLVM_ENABLE_PROJECTS=clang \
-DLLVM_TARGETS_TO_BUILD=RISCV \
-DBUILD_SHARED_LIBS=True \
-DLLVM_PARALLEL_LINK_JOBS=1 \
../llvm
ninja -j1 clang llc llvm-objdump
```

Şu şekilde kullanabilirsiniz `riscv32-unknown-elf-gcc` yerine:

```bash
/home/shc/projects/llvm11custom/llvm-project/build/bin/clang -target riscv32 -march=rv32imc -mabi=ilp32 --sysroot=/home/shc/projects/riscv32im-toolchain/_install/riscv32-unknown-elf --gcc-toolchain=/home/shc/projects/riscv32im-toolchain/_install -Xclang -target-feature -Xclang +x
```
