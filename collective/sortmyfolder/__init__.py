# -*- coding: utf-8 -*-

from zope.i18nmessageid import MessageFactory
sortFolderMessageFactory = MessageFactory('collective.sortmyfolder')
from AccessControl import ModuleSecurityInfo
ModuleSecurityInfo('collective.sortmyfolder.utils').declarePublic('get_obj_position_in_parent')
