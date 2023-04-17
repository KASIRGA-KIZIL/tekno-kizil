## ÖZEL BUYRUKLARI DESTEKLEYEN LLVM/CLANG TABANLI DERLEYİCİ

Aşağıdaki şekilde kurabilirsiniz:

```bash
git clone https://github.com/llvm/llvm-project
cd llvm-project
git checkout 1fdec59bffc11ae37eb51a1b9869f0696bfd5312
git apply derleyici.patch
```

Şu şekilde kullanabilirsiniz `riscv32-unknown-elf-gcc` yerine:

```bash
/home/shc/projects/llvm11custom/llvm-project/build/bin/clang -target riscv32 -march=rv32imc -mabi=ilp32 --sysroot=/home/shc/projects/riscv32im-toolchain/_install/riscv32-unknown-elf --gcc-toolchain=/home/shc/projects/riscv32im-toolchain/_install -Xclang -target-feature -Xclang +x
```
