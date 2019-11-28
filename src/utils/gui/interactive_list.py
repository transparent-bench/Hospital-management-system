from tkinter import *
from tkinter import ttk
import pprint


class InteractiveList:
    _master: ttk.Frame
    _list: Listbox

    def __init__(self, master, label=None) -> None:
        self._master = master
        self._list = label

    def render(self, data, row=0):
        if isinstance(self._list, Listbox):
            self._list.destroy()

        self._list = Listbox(self._master)

        for i in data:
            self._list.insert(END, pprint.pformat(i))

        self._list.grid(column=1, row=row, columnspan=10)
        self._list.config(width=100)
