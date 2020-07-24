from flask import Flask, render_template, Markup, request, escape, make_response, session, send_from_directory

from analytics import *
from settings import websites

app = Flask(__name__)


def get_folder(website, path):
    # default to domain as website folder
    folder = './websites/' + request.host + '/'
    # check and override if folder is specified
    for site in websites:
        if site['domain'] == website and 'folder' in site:
            folder = './websites/' + site['folder'] + '/'
            break
    if path != None and path != 'None':
        folder += path + '/'
    return folder


def split_url(path):
    parts_of_path = path.split('/')
    # get the file
    requested_file = parts_of_path[len(parts_of_path)-1]
    # get everything but the requested file
    parts_of_path.remove(requested_file)
    folder = '/'.join(parts_of_path)
    return [folder, requested_file]


@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def catch_all(path):
    # check if the requesting host is in the list of website domains
    if any(site['domain'] == request.host for site in websites):
        # if no path or path is / go to index.html
        if path == '' or path == '/':
            requested_file = 'index.html'
        else:
            requested_file = split_url(path)[1]

        folder = get_folder(request.host, split_url(path)[0])
        # check if .html is in requested file name
        # and if not 127.0.0.1:5000
        #print('folder: ', folder, ' requested_file: ', requested_file)
        if '.html' in requested_file and request.host != '127.0.0.1:5000':
            return set_cookie(send_from_directory(folder, requested_file))
        else:
            return send_from_directory(folder, requested_file)
    else:
        # prevent people visiting the ip or spoofing the domain
        # from visiting the websites
        return json.dumps({'error': 'Why are you here?'}), 401


@ app.route("/viewanalytics")
def view_analytics():
    visits_by_ip = 'Number of unique ips: ' + get_total_num_unique_ips(0) + '<br>\nNumber of unique ips in the last 24 hours: ' + get_total_num_unique_ips(
        1) + '<br>\nNumber of unique ips in the last week: ' + get_total_num_unique_ips(7) + '<br>\n'

    visits_by_cookie = 'Number of unique cookies: ' + get_total_num_unique_cookies(0) + '<br>\nNumber of unique cookies in the last 24 hours: ' + get_total_num_unique_cookies(
        1) + '<br>\nNumber of unique cookies in the last week: ' + get_total_num_unique_cookies(7) + '<br>\n'

    html = visits_by_ip + '<br>\n' + \
        visits_by_cookie + "<br>\n" + \
        get_unique_cookies_chart_data() + '<br>\n' + \
        '<h3>Unique IP addresses in the last day:</h3>' + \
        str(get_unique_ip_addresses(1)) + \
        '<h3>Unique URLs in the last day:</h3>' + \
        str(get_unique_urls(1))

    return html


if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=True)
