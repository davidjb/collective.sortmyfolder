#!/bin/sh

DOMAIN1='collective.sortmyfolder'
i18ndude rebuild-pot --pot locales/${DOMAIN1}.pot --merge locales/${DOMAIN1}-manual.pot --create ${DOMAIN1} .
i18ndude sync --pot locales/${DOMAIN1}.pot locales/*/LC_MESSAGES/${DOMAIN1}.po

DOMAIN2='plone'
i18ndude rebuild-pot --pot i18n/${DOMAIN2}-temp.pot --create ${DOMAIN2} .
i18ndude filter i18n/${DOMAIN2}-temp.pot i18n/${DOMAIN2}-exclude.pot > i18n/${DOMAIN1}-${DOMAIN2}.pot
rm i18n/${DOMAIN2}-temp.pot
i18ndude sync --pot i18n/${DOMAIN1}-${DOMAIN2}.pot i18n/${DOMAIN1}-${DOMAIN2}-*.po
