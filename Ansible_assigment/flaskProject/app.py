from flask import Flask, request, render_template
from random import randint
import emoji

app = Flask(__name__)


@app.route('/', methods=['GET', 'POST'])
def home():
    name_arr = ["octocat", "honeybee", "boar", "heavy_dollar_sign", "mask",
                "jack_o_lantern", "tada", "ghost", "mahjong", "coffee", "bomb",
                "speaker", "tropical_fish", "cyclone", "trollface", "boom", "zzz"]
    if request.method == "POST":
        inline = request.get_json(force=True)
        e_name = name_arr[randint(0, len(name_arr) - 1)]
        i = 1
        outline = ""
        while i <= inline["count"]:
            outline += emoji.emojize(":" + e_name + ":") + inline["word"]
            i += 1

        rez = outline + '\n'
        return rez
    return render_template("index.html")

@app.route("/about")
def about():
    return render_template("about.html")


@app.route("/homework")
def homework():
    return render_template("homework.html")



if __name__ == '__main__':
    app.run(host=\0.0.0.0', port = 5000)
