from tkinter import *
from tkinter import ttk
from src.utils.gui.interactive_list import InteractiveList


def main():

    root = Tk()
    root.title("DMD Assignment")

    mainframe = ttk.Frame(root)
    mainframe.grid(column=0, row=0)
    root.columnconfigure(0, weight=1)
    root.rowconfigure(0, weight=1)

    data_frame = ttk.Frame(mainframe)
    data_frame.grid(row=2, columnspan=10)
    data_list = InteractiveList(data_frame)

    ttk.Label(mainframe, text="DMD Project").grid(columnspan=8, row=0, pady=30)
    ttk.Button(mainframe,
               text="Generate data",
               command=lambda: print('Not implemented yet')).grid(column=0, row=1, pady=10)
    ttk.Button(mainframe,
               text="Drop database",
               command=lambda: print('Not implemented yet')).grid(column=1, row=1, pady=10)
    ttk.Button(mainframe,
               text="Show 1",
               command=lambda: data_list.render(generate_data())).grid(column=2, row=1, pady=10)
    ttk.Button(mainframe,
               text="Show 2",
               command=lambda: data_list.render(generate_data())).grid(column=3, row=1, pady=10)
    ttk.Button(mainframe,
               text="Show 3",
               command=lambda: data_list.render(generate_data(4, 123))).grid(column=4, row=1, pady=10)
    ttk.Button(mainframe,
               text="Show 4",
               command=lambda: data_list.render(generate_data(3, 12))).grid(column=5, row=1, pady=10)
    ttk.Button(mainframe,
               text="Show 5",
               command=lambda: data_list.render(generate_data(1, 10))).grid(column=6, row=1, pady=10)
    ttk.Button(mainframe,
               text="Show 6",
               command=lambda: data_list.render(generate_data(5, 29))).grid(column=7, row=1, pady=10)


    root.mainloop()

if __name__ == '__main__':
    main()