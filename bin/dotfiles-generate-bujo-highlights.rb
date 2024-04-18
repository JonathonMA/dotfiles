#!/usr/bin/env ruby

# rubocop:disable Style/HashAsLastArrayItem
highlights = {
  note: [
    "-", "●",
    inspiration: ["!", "🗲"],
  ],
  event: [
    "+", "♢",
    complete: ["X", "♦"],
  ],
  task: [
    "*", "★",
    complete: ["X", "✔"],
    priority: ["*", "🟏"],
    migrated: [">", "⮡"],
    scheduled: ["<", "⮌"],
    cancelled: ["~", "✘"],
  ],
}
# rubocop:enable Style/HashAsLastArrayItem

def map(from, to, *path, context:)
  group = ["@bujo", *path].join(".")
  <<~SCHEME
    (((#{context}) @org.#{context} (#eq? @org.#{context} "#{from}")) #{group} (#set! conceal "#{to}"))
  SCHEME
end

hx = [";; extends\n"]
hx += highlights.map do |base, (from, to, extra)|
  [
    "; #{base}s\n",
    map(from, to, base, context: "bullet"),
    extra.map do |ext, (extfrom, toext)|
      map("#{from}#{extfrom}", toext, base, ext, context: "expr")
    end,
  ].join
end

path = File.join ENV.fetch("FRESH_LOCAL"), "config/nvim/after/queries/org/highlights.scm"
File.write path, hx.join("\n")
