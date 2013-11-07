# Importers
extendr = require('extendr')

# Configuration
module.exports = docpadConfig =

	# These are variables will be accessible via our templates
	templateData:
		# Default Meetup info
		meetup:
			price: null  # if your event is free, set to null, otherwise set to something like "$100"
			venue: "Meetup Venue"
			address: "Meetup Address"
			city: "Meetup City"
			state: "Meetup State"
			country: "Meetup Country"

			# List of Sponsors
			sponsors: [
				{
					name: "Eventick",
					logo: "themes/yellow-swan/img/sponsor.png",
					url: "http://eventick.com.br"
				}
			]

			# List of Partners
			partners: [
				{
					name: "BrazilJS",
					logo: "themes/yellow-swan/img/partner.png",
					url: "http://braziljs.org"
				}
			]

			# The Call To Action button at the header,
			# If you don't want this, just remove the callToAction property.
			callToAction:
				text: "Reserve your seat!",
				link: "http://www.meetup.com/sydney-node-ninjas"

		# Site Info
		site:
			name: "Meetup Name"
			description: "Meetup Description"

			# General site information
			theme: "yellow-swan"

			# Services
			services:
				googleAnalytics: "UA-33656081-1"

			# "Fork me on GitHub", if you don't want this, just remove the forkButton property
			forkButton:
					repository: "https://github.com/docpad/meetup-boilerplate"

			# Active sections on the website
			# to deactivate comment out with "#"
			# you can also change order here and it will reflect on page
			sections: [
				'about'
				'location'
				'speakers'
				'schedule'
				'sponsors'
				'partners'
				#'contact'
				'previous'
			]

		# Labels which you can translate to other languages
		labels:
			about: "About"
			location: "When & Where"
			speakers: "Speakers"
			schedule: "Schedule"
			sponsors: "Sponsors"
			partners: "Partners"
			contact: "Contact"
			previous: "Previous Events"

		# Theme path
		getSiteUrl: -> (@site.url or '').replace(/\/+$/, '')+'/'
		getThemeUrl: -> "#{@getSiteUrl()}themes/#{@site.theme}/"

		# Next meetup with inherited default values
		getMeetup: (meetup) ->
			meetup ?= @getCollection('meetups').models[0]?.toJSON()
			meetup.name = meetup.title  if meetup.title
			meetup.description ?= meetup.contentRenderedWithoutLayouts or null

			meetup = extendr.safeShallowExtendPlainObjects(@meetup, meetup)
			meetup.date = new Date(meetup.date)
			meetup.fullAddress = """
				#{meetup.venue}, #{meetup.address},	#{meetup.city}, #{meetup.state}, #{meetup.country}
				"""

			return meetup

	collections:
		meetups: ->
			@getCollection('documents').findAllLive({relativeOutDirPath:'meetups'}, [date:-1])

	environments:
		production:
			site:
				url: "http://docpad.github.io/meetup-boilerplate/"
