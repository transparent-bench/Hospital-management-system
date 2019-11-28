import re
from tkinter import *
from tkinter import ttk
from tkinter.messagebox import showinfo

from src.utils.gui.interactive_list import InteractiveList
from src.utils.controller import fetch_by_index
from src.utils.gui.status_checker import status_checker


def main():
    root = Tk()
    root.title("DMD Assignment")

    mainframe = ttk.Frame(root)
    mainframe.grid(column=0, row=0)
    root.columnconfigure(0, weight=1)
    root.rowconfigure(0, weight=1)

    data_frame = ttk.Frame(mainframe, width=100)
    data_frame.grid(column=3, row=1, rowspan=10)
    data_frame.config()
    data_list = InteractiveList(data_frame)
    select_1_input = ttk.Entry(mainframe, width=15)
    select_1_input.grid(column=2, row=2, padx=5)

    def select_1_checker():
        regex = re.compile('\+\d{11}')
        number = select_1_input.get()

        if regex.match(number):
            data_list.render(fetch_by_index('1', number))
        else:
            showinfo('Oops!', 'Looks like you put something wrong into textfield!')

    ttk.Label(mainframe, text="DMD Project").grid(columnspan=4, row=0, pady=30)

    ttk.Button(mainframe,
               text="Generate data",
               command=lambda: status_checker(fetch_by_index('generate'))).grid(column=0, row=1, pady=10)
    ttk.Button(mainframe,
               text="SELECT 1",
               command=lambda: select_1_checker()).grid(column=0, row=2, pady=10)
    ttk.Button(mainframe,
               text="SELECT 2",
               command=lambda: data_list.render(fetch_by_index('2'))).grid(column=0, row=3, pady=10)
    ttk.Button(mainframe,
               text="SELECT 3-1",
               command=lambda: data_list.render(fetch_by_index('3-1'))).grid(column=0, row=4, pady=10)
    ttk.Button(mainframe,
               text="SELECT 3-2",
               command=lambda: data_list.render(fetch_by_index('3-2'))).grid(column=0, row=5, pady=10)
    ttk.Button(mainframe,
               text="SELECT 4",
               command=lambda: data_list.render(fetch_by_index('4'))).grid(column=0, row=6, pady=10)
    ttk.Button(mainframe,
               text="SELECT 5",
               command=lambda: data_list.render(fetch_by_index('5'))).grid(column=0, row=7, pady=10)

    ttk.Button(mainframe,
               text="Drop database",
               command=lambda: fetch_by_index('drop_and_create')).grid(column=1, row=1, pady=10)
    ttk.Button(mainframe,
               text="SELECT 1 GENERATE",
               command=lambda: data_list.render(fetch_by_index('td_1'))).grid(column=1, row=2, pady=10)
    ttk.Button(mainframe,
               text="SELECT 2 GENERATE",
               command=lambda: status_checker(fetch_by_index('td_2'))).grid(column=1, row=3, pady=10)
    ttk.Button(mainframe,
               text="SELECT 3 GENERATE",
               command=lambda: status_checker(fetch_by_index('td_3'))).grid(column=1, row=4, pady=10)
    ttk.Button(mainframe,
               text="SELECT 4 GENERATE",
               command=lambda: status_checker(fetch_by_index('td_4'))).grid(column=1, row=6, pady=10)
    ttk.Button(mainframe,
               text="SELECT 5 GENERATE",
               command=lambda: status_checker(fetch_by_index('td_5'))).grid(column=1, row=7, pady=10)

    root.mainloop()

if __name__ == '__main__':
    main()