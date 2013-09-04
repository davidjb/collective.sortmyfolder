from Acquisition import aq_inner
from Products.CMFPlone.CatalogTool import getObjPositionInParent
from ZODB.POSException import ConflictError


def get_obj_position_in_parent(context):
    """Replacement for the getObjPositionInParent.py skin script.

    This was removed from Products/CMFPlone in Plone 4 because the
    underlying technology was radically changed.

    This returns an integer.  Note that this will be zero for items
    that are not in an ordered folder.
    """
    try:
        result = getObjPositionInParent(aq_inner(context))()
        return int(result)
    except ConflictError:
        raise
    except:
        # Do not fail when for any reason the getObjPositionInParent
        # call fails.  Maybe this gets called on non-content items.
        pass
    return 0
