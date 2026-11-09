# dotfiles

この Linux マシンで実際に使っている設定を chezmoi で保存するリポジトリ。
管理場所は `~/Programs/Github/dotfiles` に統一する。

## ファイルの関係

```text
~/.config/nvim など、アプリが読む実ファイル
    ── chezmoi add / re-add ──> このリポジトリ
    <──── chezmoi apply ────── このリポジトリ

このリポジトリ ── git commit ──> ローカル履歴 ── git push ──> GitHub
```

chezmoi は常時同期しない。実ファイルを編集しただけではリポジトリに保存されず、
`git commit` しただけでは GitHub に送信されない。

`private_dot_config/nvim/init.lua` は `~/.config/nvim/init.lua` に対応する。
`dot_` は先頭の `.`、`private_` はファイル・ディレクトリの権限を表す。
`private_` は暗号化でも GitHub の非公開設定でもない。

## 普段の保存手順

いつもの `~/.config/...` を編集したら、既に管理しているファイルを取り込む。

```sh
chezmoi re-add
chezmoi git -- diff
chezmoi git -- add -A
chezmoi git -- commit -m "Update Linux dotfiles"
```

新しく作ったファイルは明示して追加する。`re-add` は新規ファイルを発見しない。

```sh
chezmoi add ~/.config/nvim/lua/plugins/example.lua
```

実ファイルを削除したときは、管理元からも外す。`forget` 自体は実ファイルを削除しない。

```sh
chezmoi forget ~/.config/nvim/lua/plugins/example.lua
```

どちらの場合も、続けて上の `diff` / `add` / `commit` で保存する。
GitHub へ公開・同期する際は、変更内容を確認してから明示的に push する。
自動 commit / push は無効。

## 確認と反映

```sh
chezmoi source-path        # ~/Programs/Github/dotfiles
chezmoi managed            # 管理対象
chezmoi status             # 実ファイルとの差分概要
chezmoi diff               # apply で実ファイルに加わる変更
chezmoi git -- status      # リポジトリの未コミット変更
```

`chezmoi diff` と `git diff` は方向が異なる。
現在の実ファイルを保存する操作は `add` / `re-add`。
リポジトリ側の変更を実ファイルに反映するときだけ、`chezmoi diff` を確認して
`chezmoi apply` を実行する。`chezmoi update` は取得に加えて反映も行う。

## 管理対象

| 設定 | 対象 |
| --- | --- |
| シェル | `.bashrc`、`.bash_logout`、`.profile`、fish の `config.fish` |
| Neovim | `init.lua`、`lua/`、`coc-settings.json`、`lazy-lock.json` |
| ターミナル | Alacritty の TOML / 既存 YAML、`.tmux.conf` |
| Git | `.gitconfig`、`.config/git/ignore` |
| その他 | `.condarc`、bottom の `bottom.toml` |

認証情報、履歴、キャッシュ、AI ツールの実行状態やローカル許可は対象外。
fish の `fish_variables` は自動更新される状態ファイルなので Git 管理しない。
ユーザーサービスや GUI の設定も今回の取り込み対象に含めていない。

今回の復旧は現行ファイルをそのまま保存したもの。`/home/duck/...` の絶対パスや、
既存のツール・フォントへの依存は残っている。別マシンの完全な構築手順ではない。
Alacritty の YAML と TOML は両方保存し、統合やアプリ設定の変更は行っていない。

## このマシンの chezmoi 設定

`~/.config/chezmoi/chezmoi.toml` の `sourceDir` がこのリポジトリを指す。
旧 `~/.local/share/chezmoi` は同じ場所へのシンボリックリンクで、別のコピーではない。
このマシン固有の chezmoi 設定と変更前のバックアップは Git 管理の外に置く。
`umask = 0o022` を指定し、設定ファイルは `644`、通常の設定ディレクトリは `755`、
`private_` のディレクトリは `700` とする。

復旧の記録・バックアップの場所は [復旧記録](docs/linux-recovery-2026-11-09.md) にある。

公式リファレンス: [日常操作](https://www.chezmoi.io/user-guide/daily-operations/)、
[add](https://www.chezmoi.io/reference/commands/add/)、
[re-add](https://www.chezmoi.io/reference/commands/re-add/)、
[forget](https://www.chezmoi.io/reference/commands/forget/)。
