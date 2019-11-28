from tkinter.messagebox import showinfo


def status_checker(status):
    if status:
        showinfo("DONE!", "Done!")
    else:
        showinfo("OOPS!", "Ooops, something went wrong!")
