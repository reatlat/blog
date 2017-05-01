# jekyll-amp-img
#
# Provides Liquid tag for convinient <amp-img> inclusion.
#
# https://www.ampproject.org/docs/guides/responsive/control_layout
#
# Copyright (C) 2017 Alex Zappa (https://reatlat.net/)
#
# The MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the “Software”), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
# of the Software, and to permit persons to whom the Software is furnished to do
# so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

module Jekyll
  class Render_ampImg < Liquid::Tag

    def initialize(tag_name, options, tokens)
      super
      @options =options.split(" | ")
      @src = @options[0]
      @layout = @options[1]
      @sizes = @options[2].split("x") if !@options[2].nil? && !@options[2].empty?
      @sizes = " width=#{@sizes[0]} height=#{@sizes[1]}" if !@sizes.nil? && !@sizes.empty?
      @alt = " alt='#{@options[3]}'" if !@options[3].nil? && !@options[3].empty?
    end

    def render(context)
      "<amp-img src='#{@src}'#{@sizes} layout='#{@layout}'#{@alt}></amp-img>"
    end
  end
end

Liquid::Template.register_tag('img', Jekyll::Render_ampImg)

