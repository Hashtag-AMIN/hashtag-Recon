import random

USER_AGENTS = [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Edge/91.0.864.48",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0) Gecko/20100101 Firefox/91.0",
    "Mozilla/5.0 (Android; Tablet; rv:40.0) Gecko/40.0 Firefox/40.0",
    "Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko",
    "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)",
    "Mozilla/5.0 (Windows NT 6.2; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0",
    "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; WOW64; Trident/7.0)"
]

def run_x8_url_header(url, wordlist, method, header, max_param, body, additional_cmd):
        
        command = ["x8", "--headers", "--append"]
        command.extend(["--url", url])
        command.extend(["--wordlist", str(wordlist)])
        command.extend(["--max", str(max_param)])
        command.extend(["--output", f"{url.split("/")[2].split(":")[0]}-hheader.txt"])
        header = header if header else []
        command.extend(["-H", f"User-Agent: {random.choice(USER_AGENTS)}"] + header)
        if method:
                command.extend(["--method"] + method)
        if body:
                command.extend(["--body", body])
        if additional_cmd:
                command.extend(additional_cmd.split())

        return command
                
def run_x8_raw_header(request, wordlist, max_param, additional_cmd):
        
        command = ["x8", "--headers", "--append"]
        command.extend(["--request", str(request)])
        command.extend(["--wordlist", str(wordlist)])
        command.extend(["--max", str(max_param)])
        command.extend(["--output", f"{str(request).split("/")[-1].split('.')[0]}-hheader.txt"])
        if additional_cmd:
                command.extend(additional_cmd.split())
        
        return command