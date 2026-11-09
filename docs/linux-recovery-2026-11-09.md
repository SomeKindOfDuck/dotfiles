# Linux dotfiles 復旧記録 — 2026-11-09

## 調査結果

`~/Programs/Github/dotfiles` と `~/.local/share/chezmoi` は独立した Git checkout だった。
両方の HEAD は `afcee45a01bee2e469e9d0dbb2710fe22b5eac7c`（2024-01-23）、
未コミット変更はなく、追跡している28ファイルも同一だった。
chezmoi は既定の `~/.local/share/chezmoi` を参照していた。

| 比較 | 結果 |
| --- | --- |
| 旧管理ファイルと実ファイル | 4件一致、21件変更、3件削除済み |
| GitHub の `SomeKindOfDuck/dotfiles` の HEAD / main | 読み取り専用の `git ls-remote` で同じ `afcee45` と確認 |
| `~/Programs/Github/dotfiles` の origin | `https://github.com/SomeKindOfDuck/dotfiles` |
| 旧 chezmoi checkout の origin | `git@github.com:7cm-diameter/dotfiles.git` |

今回は前者の origin を保持。旧 checkout の Git 設定・履歴はバックアップに保存した。

## 実施した変更

- `~/Programs/Github/dotfiles` を唯一の管理元に指定。
- 旧 chezmoi checkout を退避し、その場所を管理元へのシンボリックリンクに変更。
- 実ファイルの内容をそのまま37ファイル取り込み。
- 削除済みの `isort.lua`、`symbol-outline.lua`、`yarepl.lua` を管理元から削除。
- 新規に Neovim の `aerial.lua`、`iron.lua`、`claudecode.lua`、Alacritty の TOML、
  Bash の3ファイル、Git の2ファイル、tmux、conda、bottom を追加（計12ファイル）。
- 除外設定と日常操作の README を追加。自動 commit / push を無効化。
- chezmoi の `umask` を `022` に設定し、31ファイルを `664 → 644`、
  7ディレクトリを `775 → 755` に変更。既存の private ディレクトリは `700` を保持。

設定の内容・キーバインド・プラグイン構成は変更していない。
GitHub への同期は自動ではなく、明示的な push で行う。

## 検証

- 管理対象37ファイルの SHA-256 が復旧前の実ファイルと一致。
- 管理対象外の fish 状態ファイルと Neovim のローカル AI 設定も変更なし。
- 削除済み3ファイルが実環境に再生成されていないことを確認。
- chezmoi の取り込み時の秘密情報検査を通過。
- Bash / fish / Lua の構文検査28件と JSONC / JSON / TOML / YAML の解析6件を通過。
- 空の一時ホームへ `apply` し、37ファイルだけが生成され、内容・権限が実環境と一致。
- `chezmoi verify` 成功。`chezmoi status` / `chezmoi diff` は出力なし。
- Git の変更差分について空白エラーを検査。既存 `.bashrc` の134行目のコメントに
  末尾空白が1件あり、実ファイルの内容を保存するためそのまま保持した。

この実行セッションでは Snap ランチャーが起動制限により失敗したため、
インストール済みの `/snap/chezmoi/current/chezmoi` を直接使用した（v2.74.0）。
通常の端末でも Snap が動作しないと断定したものではなく、Snap や PATH は変更していない。

## 保存範囲

fish の `fish_variables` は Git 管理せず、変更前バックアップに保存した。
ここには `PYENV_ROOT`、`RUST_ROOT`、`JULIA_NUM_THREADS`、`fish_user_paths` などがある。
別マシンで同じ環境を再構築するときは、これらの宣言的な設定への移行が別途必要。

ユーザーサービス、GUI 設定、認証情報、履歴、AI ツールの状態も今回の管理対象外。
ツール本体・プラグイン・フォントのインストールや、アプリの実動作検査は実施していない。
Alacritty の既存 YAML と TOML の統合も行っていない。

## バックアップ

場所: `~/.local/state/dotfiles/backups/20261109T080811Z/`（所有者のみアクセス可能）。

| ファイル / ディレクトリ | 内容 |
| --- | --- |
| `before.tar.gz` | 変更前の両 Git checkout、chezmoi 設定・状態、選択した実ファイル、fish 状態 |
| `before.json` | 実ファイルの SHA-256・権限・mtime、管理対象ディレクトリの元の権限 |
| `legacy-chezmoi-source/` | 退避した旧 chezmoi checkout（`.git` を含む） |
| `permission-changes.json` | 権限を変更した38エントリと変更前後の値 |
| `validation.json` | 検証結果 |
| `candidate-chezmoi.toml` | 検証に使用した、新しいローカル chezmoi 設定のコピー |

アーカイブ内のパスはホームからの相対パス。
元の chezmoi 設定ディレクトリには状態 DB だけがあり、`chezmoi.toml` は存在しなかった。
復旧前のリポジトリ内容は今回のローカルコミットの親にも残る。
