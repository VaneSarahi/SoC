# SoC

# Procesador RISC-V de Ciclo Único (RV32I) en Verilog

## 🎯 Objetivo
Implementar una arquitectura de procesador RISC-V con diseño de ciclo único (*single-cycle*) en Verilog, integrando todos los bloques funcionales necesarios, verificando su comportamiento mediante simulación y analizando su funcionamiento instrucción por instrucción.

## 🛠️ Requerimientos
* Conocimientos básicos de arquitectura de computadores (etapas de ejecución de instrucciones).
* Familiaridad con el conjunto de instrucciones RISC-V RV32I.
* Conocimientos en diseño digital con Verilog.
* **Herramientas recomendadas:** ModelSim, Quartus, EDA Playground u OSSCAD.

---

## 🧩 Bloques Funcionales Implementados

El procesador se compone de los siguientes módulos estructurados en Verilog:

| Módulo | Archivo | Función Principal |
| :--- | :--- | :--- |
| **Program Counter** | `PC.v` | Mantiene y actualiza la dirección de la instrucción actual en cada ciclo de reloj. |
| **Instruction Memory** | `IM.v` | Memoria ROM de 256 palabras que almacena el conjunto de instrucciones del programa (carga un archivo `.hex`). |
| **Register File** | `RF.v` | Banco de registros (32 registros de 32 bits) con soporte para dos lecturas simultáneas y una escritura síncrona. |
| **Immediate Generator** | `Immediate.v` | Extrae y extiende el signo de los campos inmediatos según el tipo de instrucción (I, S, B, J). |
| **ALU Control** | `ALU_Decoder.v` | Genera la señal de operación específica para la ALU a partir de `ALUOp`, `funct3` y `funct7`. |
| **ALU** | `ALU.v` | Unidad lógica-aritmética que ejecuta operaciones aritméticas, lógicas y corrimientos, además de calcular la bandera `Zero` (`flag`). |
| **Control Unit** | `CU.v` | Decodificador principal que genera las señales de control globales del camino de datos según el `opcode`. |
| **Data Memory** | `DM.v` | Memoria RAM de 256 posiciones para operaciones de lectura/escritura de datos (`lw` / `sw`). |
| **Multiplexores** | `MUX_par.v` | Módulo parametrizado para la selección de flujos de datos hacia la ALU o cálculo del siguiente PC. |
| **Adder** | `Adder.v` | Sumador de 32 bits para el cálculo secuencial de instrucciones (PC+4) y direcciones de salto (PC + Inmediato). |

---

## 📂 Estructura del Proyecto

La organización de los archivos en el espacio de trabajo sigue la siguiente estructura:

```text
/riscv_single_cycle/
│
├── src/
│   ├── top.v               <- Módulo principal (interconexión global del Datapath)
│   ├── PC.v                <- Program Counter
│   ├── IM.v                <- Instruction Memory (Memoria ROM)
│   ├── CU.v                <- Control Unit (Decodificador principal)
│   ├── ALU_Decoder.v       <- Decodificador secundario de la ALU
│   ├── RF.v                <- Register File (Banco de registros)
│   ├── Immediate.v         <- Generador de Inmediatos
│   ├── ALU.v               <- Unidad Aritmético Lógica
│   ├── DM.v                <- Data Memory (Memoria de datos RAM)
│   ├── MUX_par.v           <- Multiplexor Parametrizado
│   └── Adder.v             <- Sumador de 32 bits
│
├── testbench/
│   └── top_tb.v            <- Testbench global para simulación completa
│
└── program/
    └── instrMem.hex        <- Código ensamblado en formato hexadecimal para ejecutar
