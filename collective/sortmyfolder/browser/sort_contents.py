# -*- coding: utf-8 -*-

from Products.Five import BrowserView
from Products.Five.browser.pagetemplatefile import ViewPageTemplateFile


class SortContentsView(BrowserView):
    """The view for sorting folders"""

    template = ViewPageTemplateFile("sort_contents.pt")

    def __init__(self, context, request):
        self.context = context
        self.request = request
        # Watch out: if the restrictedTraverse fails and there is no
        # fallback, the action will not show up in the actions drop
        # down and you will see no error or warning about it.
        if context.restrictedTraverse('getObjPositionInParent', False):
            self.use_position_script = True
        else:
            self.use_position_script = False
        self.request.set('disable_border', True)

    def __call__(self, *args, **kw):
        return self.template()
