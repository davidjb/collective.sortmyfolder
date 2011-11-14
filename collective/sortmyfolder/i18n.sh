#!/bin/sh

DOMAIN1='collective.sortmyfolder'
i18ndude rebuild-pot --pot locales/${DOMAIN1}.pot --merge locales/${DOMAIN1}-manual.pot --create ${DOMAIN1} .
i18ndude sync --pot locales/${DOMAIN1}.pot locales/*/LC_MESSAGES/${DOMAIN1}.po

DOMAIN2='plone'
i18ndude rebuild-pot --pot i18n/${DOMAIN2}-temp.pot --create ${DOMAIN2} .
i18ndude filter i18n/${DOMAIN2}-temp.pot i18n/${DOMAIN2}-exclude.pot > i18n/${DOMAIN1}-${DOMAIN2}.pot
rm i18n/${DOMAIN2}-temp.pot
i18ndude sync --pot i18n/${DOMAIN1}-${DOMAIN2}.pot i18n/${DOMAIN1}-${DOMAIN2}-*.po

# The core plone domain translations are handled using an i18n
# directory in Plone 3 and a locales directory in Plone 4.  So if we
# want to support both, we should include both.  In zcml we need to
# make sure to conditionally include the locales: not on Plone 3 but
# only on Plone 4, otherwise we may loose all other translations.  We
# put the plone translations in a plonelocales directory, as we still
# always want the locales for the translations of our own domain.
i18ndude sync --pot i18n/${DOMAIN1}-${DOMAIN2}.pot plonelocales/*/LC_MESSAGES/${DOMAIN2}.po

# Optionally copy the plone translations from i18n to plonelocales or
# the other way around.  Let's not do this by default, as it will be
# unexpected.
for dir in plonelocales/*/; do
    lang=$(echo $dir | cut -d "/" -f2)
    ## i18n is canonical, copy to locales:
    #cp i18n/${DOMAIN1}-plone-${lang}.po plonelocales/$lang/LC_MESSAGES/plone.po
    ## locales is canonical, copy to i18n:
    #cp plonelocales/$lang/LC_MESSAGES/plone.po i18n/${DOMAIN1}-plone-${lang}.po
done
