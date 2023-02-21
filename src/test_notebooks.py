from pathlib import Path 
import os
import subprocess


def run_shell_cmd(cmd,cwd=[],verbose=False):
    """ run a command in the shell using Popen
    """
    stdout_holder = []
    stderr_holder = []

    if cwd:
        process = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE,
                                        stderr=subprocess.PIPE,cwd=cwd)
    else:
        process = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE,
                                        stderr=subprocess.PIPE)

    for line in process.stdout:
        if verbose:
             print(line.strip().decode('UTF-8'))
        stdout_holder.append(line.strip().decode('UTF-8'))
    for line in process.stderr:
        if verbose:
            print(line.strip().decode('UTF-8'))
        stderr_holder.append(line.strip().decode('UTF-8'))

    process.wait()
    return (stdout_holder,stderr_holder)


if __name__ == "__main__":
    path = Path(__file__).parent.absolute()
    notebooks = [path / f for f in path.glob("*.ipynb") if 'nbconvert' not in str(f)]
    notebooks.sort()
    for notebook in notebooks:
        print(f"\nTesting {notebook}")
        converted = notebook.as_posix().replace('ipynb', 'nbconvert.ipynb')
        assert converted != notebook.as_posix(), f"converted file name must differ"
        output = run_shell_cmd(f"jupyter nbconvert --to notebook --execute {notebook.as_posix()}")
        if os.path.exists(converted):
            print(f"{notebook} passed")
            os.remove(converted)
        else:
            print(f"{notebook} failed")
            print(output)
