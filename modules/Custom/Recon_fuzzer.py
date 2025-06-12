import random

USER_AGENTS = [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Edge/91.0.864.48",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0) Gecko/20100101 Firefox/91.0",
    "Mozilla/5.0 (Android; Tablet; rv:40.0) Gecko/40.0 Firefox/40.0",
    "Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko",
    "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)",
    "Mozilla/5.0 (Windows NT 6.2; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0",
    "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; WOW64; Trident/7.0)"
]

def run_ffuf_url(url, headers, cookie, data, method, redirect, wordlist, thread, delay, additional_cmd):
        
        command = ["ffuf", "-noninteractive", '-mc', 'all', '-fc', '404','-c', '-of', 'csv']
        command.extend(["-u", url])
        for w in wordlist:
                command.extend(["-w", str(w)])
        command.extend(["-o", f"{url.split("/")[2].split(":")[0]}-fuzzer.txt"])
        if headers:
                for header in headers:
                        command.extend(['-H',f'{header}'])
        command.extend(["-H", f"User-Agent: {random.choice(USER_AGENTS)}"])
        if cookie:
                command.extend(['-b', f'{cookie}'])
        if data:
                command.extend(["-d", f'{data}'])
        if method:
                command.extend(["-X", f'{method}'])
        if redirect:
                command.extend(['-r'])
        if thread:
                command.extend(["-t", thread])
        if delay:
                command.extend(['-p',f'{delay}'])
        if additional_cmd:
                command.extend(additional_cmd.split())

        return command
                
def run_ffuf_raw(request, headers, cookie, data, method, redirect, wordlist, thread, delay, additional_cmd):
        
        command = ["ffuf", "-noninteractive", '-mc', 'all', '-fc', '404','-c', '-of', 'csv']
        command.extend(["-request", str(request)])
        for w in wordlist:
                command.extend(["-w", str(w)])
        command.extend(["-o", f"{str(request).split("/")[-1].split(".")[0]}-fuzzer.txt"])
        if headers:
                for header in headers:
                        command.extend(['-H',f'{header}'])
        command.extend(["-H", f"User-Agent: {random.choice(USER_AGENTS)}"])
        if cookie:
                command.extend(['-b', f'{cookie}'])
        if data:
                command.extend(["-d", f'{data}'])
        if method:
                command.extend(["-X", f'{method}'])
        if redirect:
                command.extend(['-r'])
        if thread:
                command.extend(["-t", thread])
        if delay:
                command.extend(['-p',f'{delay}'])
        if additional_cmd:
                command.extend(additional_cmd.split())

        return command
