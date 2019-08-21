# -*- coding: utf-8 -*-

## Not a standalone Python script, run as
## scrapy runspider -a url=https://zenodo.org/record/1215611 scrapy-meta.py

#  Copyright 2019 The University of Manchester
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and


import scrapy

class LinkAlternateSpider(scrapy.Spider):
    name = 'link_alternate'
    allowed_domains = ['basic']
    start_urls = ['http://basic/']

    def __init__(self, url='http://www.example.com', *args, **kwargs):
        super(LinkAlternateSpider, self).__init__(*args, **kwargs)
        self.start_urls = [url]

    @classmethod
    def from_crawler(cls, crawler, *args, **kwargs):
        spider = super(LinkAlternateSpider, cls).from_crawler(crawler, *args, **kwargs)
        return spider

    def parse(self, response):
        for href in response.xpath('//link[@rel="alternate"]/@href').getall():
            print(href)
