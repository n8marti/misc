GOAL:
Allow for localization of all wasta apps.
Localizers should have a very straightforward process of getting content in one
language, translating it into a 2nd, and sending the changes back.

See an in-file example at:
/usr/share/nemo/actions/Compress_PDF.sh

wasta-offline, localization branch
12 occurrences of zenity command.

DeepL
https://www.deepl.com/translator#en/fr/What%20else%20would%20you%20like%20to%20do%3F

**Initial Creation Procedure**
https://www.linuxtopia.org/online_books/advanced_bash_scripting_guide/localization.html

- Reformat strings for localization:

    echo "help!"
    ->  echo "$(gettext "help!")"

    zenity --info --text="zenity text" --title="wasta [Offline]"
    ->  zenity --info --text="$(gettext "zenity text")" --title="$(gettext "wasta [Offline]")"

    echo "Log file: $LOG"
    -> echo "$(eval_gettext "Log file: \$LOG")"

- List strings to be localized (just to confirm that they're properly found):
    $ xgettext --omit-header -L Shell -o - <script path>

- Create new <app>-msg.po template for localizing strings:
    $ localization/make-po-base.sh <app>
    OR
    $ xgettext --package-name="wasta-offline" -L Shell -o <app>-msg.po <app>

- Create <lg>-draft-<date>.po file:
    $ localization/make-po-lang.sh <app> <lg>
    OR
    $ xgettext --package-name="wasta-offline" -L Shell -o <lg>-draft-<date>.po <app>

- Translate the untranslated text (DeepL, manually, etc.).
    - If using DeepL:
        - First remove all line breaks, '\n'. This will give better translation results.
        - Then convert to docx: paste the content into a docx file to upload.
        - Then paste translated content of translated docx back into the draft .po.
    - Do initial technical review (see below).
    - Send rough draft to native speaker for review.
- Native speaker review
    - Check for consistent vocabulary (always use same synonym).
    - Check for coherence of complete sentences, especially across line breaks.
    - Check for proper spacing around punctuation.
    - Check for proper capitalization.
- Technical review
    - Check formatting: line breaks, quoting, etc., in gedit (useful highlighting).
    - Check that hard line breaks are consistent with English text.

- Create <app>.mo file & copy to appropriate place:
    $ localization/make-mo.sh <app> <lg>
    OR
    $ msgfmt -o install-files/locale/LC_MESSAGES/<lg>/<app>.mo install-files/<app>/po/<lg>.po
    *For testing:*
    ~/.local/share/locale/<lg>/LC_MESSAGES # for user test installation
    *For packaging:*
    /usr/share/locale/<lg>/LC_MESSAGES # for system installation


**Update Procedure**

- Assumes that some output strings have been modified or added. (If only removed,
    then they can be ignored.)

> Create new <app>-msg.po template with updated strings and line numbers:
    *Automatically done by make-po-lang.sh below*
    *$ localization/make-po-base.sh <app>*
    OR
    $ xgettext --package-name="wasta-offline" -L Shell -o <app>-msg.po <app>

- Update <lg>-draft-<date>.po files:
    *$ localization/make-po-lang.sh <app> <lg>*
    OR
    $ xgettext --package-name="wasta-offline" -L Shell -x <lg>.po -o <lg>-draft-<date>.po <script>

- Translate the untranslated text (DeepL, manually, etc.).
    - If using DeepL:
        - First remove all line breaks, '\n'. This will give better translation results.
        - Then convert to docx: paste the content into a docx file to upload.
        - Then paste translated content of translated docx back into the draft .po.
    - Do initial technical review (see above).
    - Send rough draft to native speaker for review.

- Copy new messages into existing <lg>.po file, possibly replacing existing similar ones.
    *TODO: Could maybe use xgettext to combine the files, but done manually for now.*

- Regenerate <app>.mo file & copy to appropriate place:
    *$ localization/make-mo.sh <app> <lg>*
    OR
    $ msgfmt -o install-files/locale/LC_MESSAGES/<lg>/<app>.mo install-files/<app>/po/<lg>.po


**Testing**

- Run the script under a different language:
    $ LANG=<lg> <script>
