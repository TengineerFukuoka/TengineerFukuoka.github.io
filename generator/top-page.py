import sys
import csv
import datetime
import subprocess

def escape_html(str):
    return str

def generate_events(events_path):
    result = []
    with open(events_path, 'r', newline='') as infile:
        reader = csv.DictReader(infile)
        for row in reader:
            weekday = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][datetime.date(int(row['year']), int(row['month']), int(row['date'])).weekday()]
            result.append(f'''<a href="{row['link']}" target="_blank" rel="noopener noreferrer" class="ev-link">
  <div class="ev-row">
    <div class="ev-date">
      <div class="ev-yr">{escape_html(row['year'])}</div>
      <div class="ev-day">{escape_html(row['month'])}/{escape_html(row['date'])}</div>
    </div>
    <div class="ev-weekday {weekday.lower()}">{weekday}</div>
    <div class="ev-title">{escape_html(row['title'])}</div>
  </div>
</a>''')
    return ''.join(result)

def generate(template_path, articles_generator, data):
    with open(template_path, 'r') as tpl:
        for ln in tpl:
            if ln.strip() == '$EVENTS$':
                ln = data['events']
            elif ln.strip() == '$ARTICLES$':
                sys.stdout.flush()
                subprocess.call(['bash', articles_generator], stdout=sys.stdout,
                                env={'ARTICLE_PATH_PREFIX': 'article/', 'ARTICLE_LIMIT': '5'})
                continue

            print(ln, end='')

if __name__ == '__main__':
    if len(sys.argv) != 4:
        print('top-page <template> <articles generator> <events>', file=sys.stderr)
        sys.exit(1)

    data = {}

    data['events'] = generate_events(sys.argv[3])

    generate(sys.argv[1], sys.argv[2], data)
