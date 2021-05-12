# EDC 产品代码库

## 代码结构

```
/-
  |- edc/                  标准产品库，包含各产品公共的后端代码
  |- zrplatform/edc/       中日 EDC 产品库，仅包含中日相关后端代码
  |- researchforce/edc/    RF EDC 产品库，仅包含 ResearchForce 相关后端代码
  |- frontends/            前端代码（暂时不区分哪一个产品的）
```

## 本地启动应用

安装依赖，若要开发中日 EDC，请通过 requirements-zredc.txt 来安装：

```sh
pip install -r requirements-zredc.txt
```

若要开发 RF EDC，请通过 requirements-rfedc.txt 来安装：

```sh
pip install -r requirements-rfedc.txt
```

创建配置文件：

```sh
cp nsproject/settings_local.example.py nsproject/settings_local.py

# 注意，我们新增了一个 config.yaml
cp nsproject/config.example.yaml nsproject/config.yaml
```

启动后端：

```sh
# Windows，以下两条命令分别启动中日 EDC 和 RF EDC
runserver.bat zredc
runserver.bat rfedc

# Mac/Linux，以下两条命令分别启动中日 EDC 和 RF EDC
./runserver.sh zredc
./runserver.sh rfedc
```

启动前端：

```sh
# 启动 RF EDC 前端
yarn serve-rfedc
# 启动 RF EDC admin
yarn serve-rfadmin

# 启动中日 EDC 前端
yarn serve-zredc
# 启动中日 EDC 前端
yarn serve-zradmin
```

## 开发要求

### 分支管理

开发时，分支名要求格式为 `{product}/{username}/{branch}`，其中，`{product}` 只能是以下三个之一：
`common`, `zredc`, `rfedc`，分别表示这次改动的内容是通用的、中日的还是 ResearchForce 的。CI 任务与分支名有关。
后面的 `{username}/{branch}` 与以前是一样的。


### 前端代码

目前我们前端代码没有像后端那样进行拆分，而是揉合在同一个目录中。在代码中，可以通过 `process.env.PRODUCT` 来判断，
其值为 `rfedc` 或 `zredc`。在代码中，可以通过这个值来判断当前是哪一个产品。
