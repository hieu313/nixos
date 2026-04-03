# Yazi cheatsheet

Cheatsheet ngắn cho cấu hình trong `config/yazi/`.

## Mở

```bash
yazi
yazi .
yazi /duong-dan/toi-thu-muc
```

## Di chuyển

- `j` / `k` — xuống / lên
- `h` — ra thư mục cha
- `l` — vào thư mục hoặc mở file (`smart-enter`)
- `gg` / `G` — lên đầu / xuống cuối
- `H` / `L` — back / forward
- `Ctrl-u` / `Ctrl-d` — nửa trang
- `Ctrl-b` / `Ctrl-f` — một trang

## Chọn và thao tác file

- `Space` — chọn file hiện tại
- `v` — visual mode
- `Ctrl-a` — chọn tất cả
- `Ctrl-r` — đảo chọn
- `y` — copy
- `x` — cut
- `p` — paste (`smart-paste`)
- `P` — paste ghi đè
- `a` — tạo file/thư mục
- `r` — đổi tên
- `d` — trash
- `D` — xóa vĩnh viễn

## Mở file

- `Enter` / `o` — mở file
- `O` / `Shift-Enter` — chọn opener
- Text mở bằng `nvim`
- File thường mở bằng `xdg-open`
- Media mở bằng `mpv`

## Search / filter / jump

- `f` — `jump-to-char`
- `F` — smart filter
- `/` / `?` — find next / previous
- `n` / `N` — kết quả tiếp / trước
- `s` — search tên file (`fd`)
- `S` — search nội dung (`rg`)
- `z` — nhảy thư mục qua `zoxide`
- `Z` — nhảy qua `fzf`
- `.` — bật/tắt file ẩn

## Sort / hiển thị

- `m s` — size
- `m p` — permissions
- `m m` — mtime
- `m o` — owner
- `m n` — none
- `, n` / `, N` — natural tăng / giảm
- `, m` / `, M` — mtime tăng / giảm
- `, s` / `, S` — size tăng / giảm

## Tab / task / goto

- `t` — tab mới
- `1..9` — chuyển tab
- `[` / `]` — tab trước / sau
- `{` / `}` — đổi vị trí tab
- `w` — mở task manager
- `g h` — home
- `g c` — `~/.config`
- `g d` — `~/Downloads`
- `g Space` — `cd` tương tác

## Phím custom đáng nhớ

- `l` — `smart-enter`
- `p` — `smart-paste`
- `f` — không phải filter mặc định, đã đổi sang `jump-to-char`
- `E` — `easyjump`
- `M` — mount plugin

## Plugin chính

- `git`
- `smart-enter`
- `jump-to-char`
- `smart-filter`
- `smart-paste`
- `rich-preview`
- `piper`
- `full-border`
- `mime-ext`

## Phụ thuộc ngoài

- `nvim`
- `xdg-open`
- `mpv`
- `fd`
- `rg`
- `zoxide`
- `fzf`
- `eza`

## File chỉnh cấu hình

- `config/yazi/keymap.toml` — đổi phím
- `config/yazi/yazi.toml` — hành vi chung
- `config/yazi/init.lua` — setup plugin/UI
- `config/yazi/package.toml` — plugin
