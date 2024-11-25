import tkinter as tk
from tkinter import filedialog
from tkinter import messagebox
import re

def create_gui():
    # Pantalla principal
    window = tk.Tk()
    window.title("Instruction Decoder")
    window.geometry("600x600")

    title_label = tk.Label(window, text="Instruction Decoder", font=("Arial", 24))
    title_label.pack(pady=10)

    button1 = tk.Button(window, text="Seleccionar Archivo", command=select_file)
    button1.pack(pady=10)

    global text_area
    text_area = tk.Text(window, wrap=tk.WORD, height=10, width=70)
    text_area.pack(pady=10)

    # Botón para decodificar el archivo
    global button_decode
    button_decode = tk.Button(window, text="Decodificar a Binario", command=convert_to_binary, state=tk.DISABLED)
    button_decode.pack(pady=10)

    global binary_area
    binary_area = tk.Text(window, wrap=tk.WORD, height=10, width=70)
    binary_area.pack(pady=10)

    window.mainloop()

def select_file():
    file = filedialog.askopenfilename(
        filetypes=[("Text files", "*.txt")],
        title="Selecciona un archivo TXT"
    )
    if file:
        display_text(file)

def display_text(file):
    try:
        with open(file, 'r', encoding='utf-8') as f:
            lines = f.readlines()

        text_area.delete('1.0', tk.END)
        binary_area.delete('1.0', tk.END)

        text_area.insert(tk.END, ''.join(lines))

        global loaded_text
        loaded_text = ''.join(lines)
        button_decode.config(state=tk.NORMAL)

    except Exception as e:
        messagebox.showerror("Error", f"Error al leer el archivo: {e}")

def convert_to_binary():
    try:
        instructions = loaded_text.strip().split("\n")
        binary_result = []

        for instruction in instructions:
            bin_instr = decode_instruction(instruction)
            if bin_instr:
                binary_result.append(bin_instr)
            else:
                binary_result.append(f"Error: '{instruction}' no es una instrucción válida")

        binary_area.delete('1.0', tk.END)
        binary_area.insert(tk.END, '\n'.join(binary_result))

    except Exception as e:
        messagebox.showerror("Error", f"Error al decodificar las instrucciones: {e}")

def decode_instruction(instruction):
    # Divide la instrucción en sus partes
    parts = instruction.split()
    if len(parts) < 2:
        return None

    operation = parts[0]
    args = parts[1:]

    # Diccionario de opcodes y functs
    opcodes = {"R": "000000", "addi": "001000", "lw": "100011", "sw": "101011", "j": "000010"}
    functs = {"add": "100000", "sub": "100010", "and": "100100", "or": "100101", "slt": "101010"}

    if operation in functs:  # Tipo R
        if len(args) != 3:
            return None
        rs, rt, rd = map(register_to_bin, args)
        return f"{opcodes['R']}{rs}{rt}{rd}00000{functs[operation]}"

    elif operation in ["addi", "lw", "sw"]:  # Tipo I
        if len(args) != 3:
            return None
        rt, rs = map(register_to_bin, args[:2])
        imm = int_to_bin(args[2], 16)
        return f"{opcodes[operation]}{rs}{rt}{imm}"

    elif operation == "j":  # Tipo J
        if len(args) != 1:
            return None
        address = int_to_bin(args[0], 26)
        return f"{opcodes[operation]}{address}"

    return None

def register_to_bin(register):
    """Convierte un registro a su formato binario (ej. $t0 -> 01000)"""
    registers = {
        "$zero": "00000", "$at": "00001",
        "$v0": "00010", "$v1": "00011",
        "$a0": "00100", "$a1": "00101", "$a2": "00110", "$a3": "00111",
        "$t0": "01000", "$t1": "01001", "$t2": "01010", "$t3": "01011",
        "$t4": "01100", "$t5": "01101", "$t6": "01110", "$t7": "01111",
        "$s0": "10000", "$s1": "10001", "$s2": "10010", "$s3": "10011",
        "$s4": "10100", "$s5": "10101", "$s6": "10110", "$s7": "10111",
        "$t8": "11000", "$t9": "11001", "$k0": "11010", "$k1": "11011",
        "$gp": "11100", "$sp": "11101", "$fp": "11110", "$ra": "11111"
    }
    return registers.get(register, "00000")

def int_to_bin(value, bits):
    """Convierte un entero a binario con un número fijo de bits"""
    return format(int(value), f'0{bits}b')

if __name__ == "__main__":
    create_gui()
