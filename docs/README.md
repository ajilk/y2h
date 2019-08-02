# y2h

## Specification

### YAML Representation of HTML

```yaml
<element>:
  attrs:
    - <attribute>: ""
  +:
    - <element>
	- _txt: "Just a Text"
```

|           | Description                                                              | Example                     |
| --------- | ------------------------------------------------------------------------ | --------------------------- |
| `element` | element. Only has two children: `attrs` & `+`                            | `html, img, etc.`           |
| `attrs`   | element attributes. Must contain a list of attributes                    | `class, style, align, etc.` |
| `+`       | element content. Must contain a list of elements only                    | `[ html, img, etc. ]`       |
| `_txt`    | y2h specific element. Used for injecting text into elements like `p, h1` | `[ html, img, etc. ]`       |

---

## Motive

As I was writing HTML for each individual page of my
[portfolio](https://github.com/ajilk/ajilk.github.io), I realized how much I
hate HTML. It seemed so much of my time was simply wasted on writing '<', '>'
and '/'. And these characters were placed in the most uncomfortable place to
reach on the keyboard. So I thought, there should be another way around this.
That's when YAML struck my head. What if there was way, I can specify each
HTML element using YAML. I thought, I can then reuse compound elements without
writing the whole thing. And it would also be visually pleasing to look at since
there won't unnecessary characters, just what is necessary. Well, everything
was well until I began designing the HTML representation in YAML.

## Design

As I studied the format of HTML, I began noticing obvious patterns. For
example, how each element had a name and list of attributes. And that there
are two types of HTML elements (void and nonvoid)

```html
<!-- [ void element ] -->
<div class="container p-0">
  <!-- [ nonvoid element ] -->
  <img href="./sample.png" />
</div>
```

I needed to somehow define a YAML representation such that it takes into
account all that. I was disappointed to find out that what I envisioned was not
really possible and that HTML was the way to go. Nevertheless, here is the
structure I came up with.

```yaml
<element>:
  attrs:
    - <attribute>: ""
  +:
    - <element>
	- _txt: "Just a Text"
```

It seems simple but gets very messy really quick. So the element is defined
by attributes (`attrs`) and content (`+`). Content is what goes in the
element. In the above HTML snippet the content would be the `img` element.
Once the design was enough to represent an HTML code, I began writing the
script that would interpret and convert it HTML. I was able to figure out a
way to transcompile each element without me manually coding it due to the
aforementioned HTML pattern.

## The lesson

It all worked out well. But YAML representation of HTML ended up being longer
than the actual HTML code it was aimed to represent. The whole objective of
this project or any other project in life, is to make life easier and in this
case by writing less. Although, the objective was not reached, there were
some positive results. One of the advantages was that the YAML representation
was easier on the eye and much more pleasurable to look at compared to the
HTML code. And besides I learned a lot about YAML and developed more
appreciation towards HTML.
