;; extends

; notes
(((bullet) @org.bullet (#eq? @org.bullet "-")) @bujo.note (#set! conceal "—"))
(((expr) @org.expr (#eq? @org.expr "-!")) @bujo.note.inspiration (#set! conceal "‽"))

; events
(((bullet) @org.bullet (#eq? @org.bullet "+")) @bujo.event (#set! conceal "□"))
(((expr) @org.expr (#eq? @org.expr "+X")) @bujo.event.complete (#set! conceal "■"))

; tasks
(((bullet) @org.bullet (#eq? @org.bullet "*")) @bujo.task (#set! conceal "●"))
(((expr) @org.expr (#eq? @org.expr "*X")) @bujo.task.complete (#set! conceal "✔"))
(((expr) @org.expr (#eq? @org.expr "**")) @bujo.task.priority (#set! conceal "✱"))
(((expr) @org.expr (#eq? @org.expr "*>")) @bujo.task.migrated (#set! conceal "➜"))
(((expr) @org.expr (#eq? @org.expr "*<")) @bujo.task.scheduled (#set! conceal "⬉"))
(((expr) @org.expr (#eq? @org.expr "*~")) @bujo.task.cancelled (#set! conceal "✘"))
