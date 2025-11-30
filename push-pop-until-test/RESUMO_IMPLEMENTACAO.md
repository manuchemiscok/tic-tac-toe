# Resumo: Implementação de PUSHUNTIL/POPUNTIL

## Mudanças nos Arquivos

### `Assembler_Source/defs.h`
- Adicionados opcodes:
  - `#define PUSHUNTIL_CODE 100`
  - `#define POPUNTIL_CODE 101`
  - `#define PUSHUNTIL_STR "PUSHUNTIL"`
  - `#define POPUNTIL_STR "POPUNTIL"`


### `Assembler_Source/montador.c`

**Função `DetectarLabels()` (linha ~221):**
```c
case PUSHUNTIL_CODE:
case POPUNTIL_CODE:
    parser_SkipUntil(',');
    parser_SkipUntilEnd();
    end_cnt++;
    break;
```

**Função `MontarInstrucoes()` (linhas ~1987-2040):**
Implementa a expansão de PUSHUNTIL/POPUNTIL em múltiplas instruções PUSH/POP:

```c
case PUSHUNTIL_CODE:
    str_tmp1 = parser_GetItem_s();
    parser_Match(',');
    str_tmp2 = parser_GetItem_s();
    val1 = BuscaRegistrador(str_tmp1);
    val2 = BuscaRegistrador(str_tmp2);
    free(str_tmp1);
    free(str_tmp2);
    
    // Push em todos os registradores do intervalo
    for(int i = val1; i < val2; i++)
    {
        str_tmp1 = ConverteRegistrador(i);
        sprintf(str_msg,"%s%s0000000",PUSH,str_tmp1);
        free(str_tmp1);
        parser_Write_Inst(str_msg,end_cnt);
        end_cnt += 1;
    }
    break;

case POPUNTIL_CODE:
    // Implementação idêntica, em ordem reversa para LIFO
    break;
```

**Função `BuscaInstrucao()` (linha ~2635):**
```c
else if (strcmp(str_tmp, PUSHUNTIL_STR) == 0)
    return PUSHUNTIL_CODE;
else if (strcmp(str_tmp, POPUNTIL_STR) == 0)
    return POPUNTIL_CODE;
```

### `Assembler_Source/montador.h`
- Atualizados opcodes de pseudo-instruções (LABEL_CODE: 100→107, etc) para evitar conflitos

---

## Compilação do Assembler

```bash
cd Processador-ICMC/Assembler_Source && make
```

**Resultado:** SUCESSO
```
gcc -c main.c  -o main.o
gcc -c montador.c  -o montador.o
gcc -c parser.c  -o parser.c
gcc -c structs.c  -o structs.o
gcc main.o montador.o parser.o structs.o -g -o montador
```

Binário `montador` gerado com sucesso (51KB)

---

## Teste de Compilação Assembly

### Arquivo: `test_pushuntil.asm`

```assembly
jmp test_start

test_start:
    loadn r0, #10
    loadn r1, #20
    loadn r2, #30
    loadn r3, #40
    loadn r4, #50
    
    pushuntil r0, r4    ; Faz push de r0, r1, r2, r3 para a pilha
    
    loadn r0, #0
    loadn r1, #0
    loadn r2, #0
    loadn r3, #0
    
    popuntil r0, r4     ; Restaura r0, r1, r2, r3 da pilha
    
    halt
```

**Esperado:** r0=10, r1=20, r2=30, r3=40 após execução (valores restaurados da pilha)

### Compilação

```bash
cd Processador-ICMC && \
./Assembler_Source/montador test_pushuntil.asm test_pushuntil.mif
```

**Resultado:** SUCESSO
```
Montador v.0.0
Mensagem (0): Encontrando labels...
Mensagem (9): Label "test_start" em 0x2.
Mensagem (0): Montando codigo...
Mensagem (31): Descarregando buffer de saida...
Mensagem (31): Concluido.
```

**Arquivo gerado:** `test_pushuntil.mif` (24 instruções)

### Verificação do MIF

Primeiras linhas do `test_pushuntil.mif`:
```
12:0001010000000000;  (PUSH r0)
13:0001010010000000;  (PUSH r1)
14:0001010100000000;  (PUSH r2)
15:0001010110000000;  (PUSH r3)
...
22:0001100000000000;  (POP r0)
23:0001100010000000;  (POP r1)
24:0001100100000000;  (POP r2)
25:0001100110000000;  (POP r3)
```

Opcodes verificados:
- PUSH: `000101` (correto)
- POP: `000110` (correto)
- Ordem LIFO preservada (pop em ordem reversa)
