import sys
import csv
import subprocess

def escape_html(str):
    return str

def generate(template_path, generator):
    with open(template_path, 'r') as tpl:
        for ln in tpl:
            if ln.strip() == '$ARTICLES$':
                sys.stdout.flush()
                subprocess.call(['bash', generator], stdout=sys.stdout)
            else:
                print(ln, end='')

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print('articles.py <template> <generator>', file=sys.stderr)
        sys.exit(1)

    generate(sys.argv[1], sys.argv[2])
