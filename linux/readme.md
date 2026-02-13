# linux脚本执行快捷操作

写完脚本后，需要赋予权限把脚本设置为可执行

> 以[copy-path.sh](./copy-path.sh)为例，该脚本功能为复制当前路径或当前路径下文件的路径

```bash
chmod +x copy-path.sh
```

在终端执行`./copy-path.sh`，可以看到终端正确输出了“已复制路径到剪贴板...”。

当然，这是有弊端的。那就是只能在当前路径下执行该文件，而为了快捷执行操作，需要全局执行。我们可以在终端的配置文件中，为执行这些脚本指定别名

> 我使用的终端为zsh，就以zsh举例。

打开zsh的配置文件

```bash
vim ~/.zshrc
```

然后在文件中写入

```zsh
alias cpath="~/sh/linux/copy-path.sh"
```

最后执行source命令让配置生效

```bash
source ~/.zshrc
```

试在终端执行cpath命令

```bash
cpath
```

可以看到正确输出了，并且路径也复制到了剪贴板中。
