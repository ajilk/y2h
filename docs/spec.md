# Specification

## YAML Representation of HTML

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
