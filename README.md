# Assembly Sorting Algorithms Visualizer  

## Overview  
This project implements three fundamental sorting algorithms (**Bubble Sort**, **Insertion Sort**, and **Selection Sort**) in **x86 assembly language**. Designed for low-level programming enthusiasts, it includes an interactive menu, array shuffling, and visual output to demonstrate sorting steps.  

## Features  
- **Interactive Menu**: Choose between sorting algorithms or exit the program.  
- **Real-Time Visualization**: Displays unsorted and sorted arrays after each operation.  
- **Array Shuffling**: Uses a pseudo-random number generator (`RANDOM` procedure) to reshuffle the array after sorting.  
- **Educational Focus**: Clearly demonstrates how sorting works at the register and memory level.  

## Supported Algorithms  
1. **Bubble Sort**  
2. **Insertion Sort**  
3. **Selection Sort**  

## How to Run  
1. **Assemble**: Use an assembler like MASM or NASM:  
   ```bash
   nasm -f elf Coal_Final_Project.asm -o sort.o
   ld -m elf_i386 sort.o -o sort
   ```
2. **Execute**:  
   ```bash
   ./sort
   ```
3. **Follow Prompts**:  
   - Select an algorithm (1–3) or exit (4).  
   - Observe the unsorted and sorted arrays printed to the console.  

## Example Output  
```plaintext
Select Sorting Algorithm:  
1. Bubble Sort  
2. Insertion Sort  
3. Selection Sort  
4. Exit  
1  

Unsorted Array: 5 4 3 2 1 0  
Sorted Array: 0 1 2 3 4 5  
```

## Code Structure  
- **Core Procedures**:  
  - `DISPLAY_ARRAY`: Prints the current array state.  
  - `SHUFFLE_ARRAY`: Randomizes the array using `RANDOM`.  
  - Sorting algorithms (`BUBBLE_SORT`, `INSERTION_SORT`, `SELECTION_SORT`).  
- **Data Segment**: Predefined array (`arr`) and messages for UI.  

## Dependencies  
- x86 assembler (e.g., NASM, MASM).  
- Linker (e.g., `ld` for Linux).  

## Future Enhancements  
- Add **Merge Sort** and **Quick Sort** implementations.  
- Support dynamic array input (user-defined size/elements).  
- Animate sorting steps with delays for better visualization.  

Ideal for learning assembly language and sorting algorithm internals! ⚙️
