x86_64_asm_source_files := $(shell find src/impl/x86_64 -name *.asm)
x86_64_asm_object_files := $(patsubst src/impl/x86_64/%.asm, build/x86_64/%.o, $(x86_64_asm_source_files))

$(x86_64_asm_object_files): build/x86_64/%.o : src/impl/x86_64/%.asm
	mkdir -p $(dir $@) && \
	nasm -f elf64 $(patsubst build/x86_64/%.o, src/impl/x86_64/%.asm, $@) -o $@
# ---------- C++ ----------
x86_64_cpp_source_files := $(shell find src/impl/x86_64 -name '*.cpp')
x86_64_cpp_object_files := $(patsubst src/impl/x86_64/%.cpp, build/x86_64/%.o, $(x86_64_cpp_source_files))

$(x86_64_cpp_object_files): build/x86_64/%.o : src/impl/x86_64/%.cpp
	mkdir -p $(dir $@)
	x86_64-elf-g++ -c -ffreestanding -fno-exceptions -fno-rtti \
	    -fno-stack-protector -mno-red-zone -Wall -Wextra \
	    -I src/intf \
	    $< -o $@

.PHONY: build-x86_64
build-x86_64: $(x86_64_asm_object_files) $(x86_64_cpp_object_files)
	mkdir -p dist/x86_64
	x86_64-elf-ld -n -o dist/x86_64/kernel.bin \
	    -T targets/x86_64/linker.ld \
	    $(x86_64_asm_object_files) $(x86_64_cpp_object_files)
	cp dist/x86_64/kernel.bin targets/x86_64/iso/boot/kernel.bin
	grub-mkrescue /usr/lib/grub/i386-pc -o dist/x86_64/kernel.iso targets/x86_64/iso

.PHONY: test-debug
test-debug:
	@echo "--- DEBUGGER INFO ---"
	@echo "Current Directory: $(shell pwd)"
	@echo "ASM sources : $(x86_64_asm_source_files)"
	@echo "ASM objects : $(x86_64_asm_object_files)"
	@echo "CPP sources : $(x86_64_cpp_source_files)"
	@echo "CPP objects : $(x86_64_cpp_object_files)"
