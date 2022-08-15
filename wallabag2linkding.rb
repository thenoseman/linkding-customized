#!/usr/bin/env ruby
#
# Reads a JSON wallabag export and generates a netscape HTML bookmarks file
#
require "json"
require "time"

WALLABAG_FILE = "All\ articles.json"
NETSCAPE_HTML_FILE = "wallabag_bookmarks.html"

HEADER = <<~BEND.strip
  <!DOCTYPE NETSCAPE-Bookmark-file-1>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
  <TITLE>Bookmarks</TITLE>
  <H1>Bookmarks</H1>
  <DL><p>
BEND

FOOTER = <<~BEND.strip
  </DL><p>
BEND

handle = File.open(NETSCAPE_HTML_FILE, "w")
handle.write HEADER

wallabag_json = JSON.load_file(WALLABAG_FILE)

wallabag_json.each do |bookmark|
  # "2022-07-24T16:03:11+00:00"
  created_unix = Time.parse(bookmark["created_at"]).to_i

  # TAGS
  tags = bookmark["tags"].join(",")

  # title
  title = bookmark["title"]

  # toread
  toread = bookmark["is_archived"] == 1 ? 0 : 1

  handle.write("<DT><A HREF=\"#{bookmark["url"]}\" ADD_DATE=\"#{created_unix}\" PRIVATE=\"1\" TOREAD=\"#{toread}\" TAGS=\"#{tags}\">#{title}</A>\n")
  handle.write("<DD>#{title}\n\n")
end

handle.write FOOTER
handle.close
