module Gossips
	class Configuration
		class Schema < Struct.new(:default)
			def initialize
				self.default = whiteseparated_tags
			end

			private

			def whiteseparated_tags
				{
					settings: {
						analysis: {
							analyzer: {
								gossipAnalyzer: {
									type: 'custom',
									tokenizer: 'whitespace',
									char_filter: ['dot_remover', 'coma_separator'],
									filter: ['lowercase'],
								}
							},
							char_filter: {
								dot_remover: {
									type: 'pattern_replace',
									pattern: '\.',
									replacement: ''
								},
								coma_separator: {
									type: 'pattern_replace',
									pattern: '\,',
									replacement: ' '
								}
							}
						}
					},
					mappings: {
						doc: {
							properties: {
								query: { type: 'percolator' },
								object_type: {
									type: 'keyword',
									index: true
								},
								object_id: { type: 'integer' },
								created_at: { type: 'date', format: 'yyyy-MM-dd HH:mm:ss' },
								updated_at: { type: 'date', format: 'yyyy-MM-dd HH:mm:ss' },
								tag_id: { type: 'integer' },
								tag_name: {
									type: 'text',
									analyzer: 'gossipAnalyzer'
								}
							}
						}
					}
				}
			end
		end
	end
end