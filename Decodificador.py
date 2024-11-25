import tkinter as tk
from tkinter import filedialog
from tkinter import messagebox
import re  

def create_gui():
    # Pantalla principal
    window = tk.Tk()
    window.title("Text File Deco")
    window.geometry("600x600")


    title_label = tk.Label(window, text="Deco", font=("Arial", 24))
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

        numeros = re.findall(r'\d+', loaded_text)
        binario = ' '.join(format(int(num), '08b') for num in numeros)


        binary_area.delete('1.0', tk.END)
        binary_area.insert(tk.END, binario)

    except Exception as e:
        messagebox.showerror("Error", f"Error al decodificar los números: {e}")

if __name__ == "__main__":
    create_gui()
